//
//  CTMediator.m
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "CTMediator.h"
#import <objc/runtime.h>
/// 找不到Target或Method时，会使用该基类顶上
#import "TMBaseTarget.h"

/// 处理异常情况下的Type
typedef NS_ENUM(NSInteger, CTMediatorExceptionType){
    CTMediatorExceptionTypeNone,        /// 其他异常情况
    CTMediatorExceptionTypeNoTarget,    /// 找不到Target
    CTMediatorExceptionTypeNoMethod,    /// 找不到Method
};

NSString * const kCTMediatorParamsKeySwiftTargetModuleName = @"kCTMediatorParamsKeySwiftTargetModuleName";

@interface CTMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation CTMediator

/// Target_  Action_  根据项目需要重新命名
#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static CTMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[CTMediator alloc] init];
    });
    return mediator;
}

/*
 scheme://[target]/[action]?[params]
 
 url sample:
 aaa://targetA/actionB?id=1234
 */

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params shouldCacheTarget:NO];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    NSString *swiftModuleName = params[kCTMediatorParamsKeySwiftTargetModuleName];
    
    // generate target
    NSString *targetClassString = nil;
    if (swiftModuleName.length > 0) {
        targetClassString = [NSString stringWithFormat:@"%@.Target_%@", swiftModuleName, targetName];
    } else {
        targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    }
    NSObject *target = self.cachedTarget[targetClassString];
    if (target == nil) {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }

    // generate action
    NSString *actionString = [NSString stringWithFormat:@"Action_%@:", actionName];
    SEL action = NSSelectorFromString(actionString);
    
    /// 新增备用 generate action，解决不传参创建的方式具体看demo
    NSString *actionString_packet = [NSString stringWithFormat:@"Action_%@", actionName];
    SEL action_packet = NSSelectorFromString(actionString_packet);
    
    if (target == nil) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        /// 安全防护，给一个基类Target顶上来，一定要记得实现基类的方法!【TMBaseTarget】
        return [self NoTargetActionResponseWithTargetString:targetClassString selectorString:actionString originParams:params exceptionType:(CTMediatorExceptionTypeNoTarget)];
    }
    
    /// 缓存
    if (shouldCacheTarget) {
        self.cachedTarget[targetClassString] = target;
    }

    if ([target respondsToSelector:action]) {
        /// 找到响应action的Target
        return [self safePerformAction:action target:target params:params];
    }else if ([target respondsToSelector:action_packet]){
        /// 找到响应action的Target，无传参创建方式
        return [self safePerformAction:action_packet target:target params:params];
    }else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        /// 由原来的[notFound: -> notFoundMethod:]修改这里为了区别细分业务情况
        /// 找到响应【notFoundMethod:】的Target，在项目中可以定义一个基类Target实现此方法并返回对应的提示控制器，类似【TMBaseTarget】
        /// 安全防护，给一个基类Target顶上来，一定要记得实现基类的方法!毕竟这个是完全可控的！【TMBaseTarget】
        /// 清除前移，如果有缓存到[targetClassString]，到这已经是调用失败的地方了，在处理异常的时候同时清理掉它，防止一直影响程序执行和调试。
        [self.cachedTarget removeObjectForKey:targetClassString];
        return [self NoTargetActionResponseWithTargetString:targetClassString selectorString:actionString originParams:params exceptionType:(CTMediatorExceptionTypeNoMethod)];
    }
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - private methods
/// 修改此方法统一处理异常情况[Target、Method、params为空的情况]，返回工程自定义的Target以及实现其方法
- (id)NoTargetActionResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams exceptionType:(CTMediatorExceptionType)exceptionType
{
    
    NSObject *target = [[TMBaseTarget alloc] init];
    SEL action = NSSelectorFromString(@"notFoundParams:");
    
    switch (exceptionType) {
        case CTMediatorExceptionTypeNoTarget:
        {
            action = NSSelectorFromString(@"notFoundTarget:");
        }
            break;
        case CTMediatorExceptionTypeNoMethod:
        {
            action = NSSelectorFromString(@"notFoundMethod:");
        }
            break;
        default:
            break;
    }
    
    /// 执行异常上报
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"originParams"] = originParams;
    params[@"targetString"] = targetString;
    params[@"selectorString"] = selectorString;
    
    /// 打印异常信息
    NSLog(@"%@",[NSString stringWithFormat:@"\nCTMediator内部调用异常信息：%@", params]);
    
    /// 执行异常显示，传params是确保需求的变更 更加从容，比如产品需求不同的Target显示不同的异常VC时...[BigCry]
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params];
    }
    /// 不可能会到这里，因为备用Target和备用Method都具备了，除非是没有实现
    NSAssert(0 == 1, @"按道理说不会在这里出问题的，备用Target的[notFoundMethod:]和[notFoundParams:]和[notFoundTarget:]都没有按照规定实现，所以崩溃在这里！");
    return nil;
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params
{
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];

    /// 这段代码主要是判断返回值类型,如果是void,NSInteger,BOOL,CGFloat,NSUInteger就进行特殊处理,不是的话就直接返回performSelector的返回值类型
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }

    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end
