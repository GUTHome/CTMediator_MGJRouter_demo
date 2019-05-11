//
//  ModuleRouterManager.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/4.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 全局订制工程协议
#define TMURLPatternProtocal @"TM:"
#define TMURLPatternAll(modeName, modePath) [NSString stringWithFormat:@"%@//%@/%@", TMURLPatternProtocal, (modeName), (modePath)]
#define TMURLPatternE(modePath) TMURLPatternAll(@"ModeE", modePath)
#define TMURLPatternF(modePath) TMURLPatternAll(@"ModeF", modePath)
#define TMURLPatternI(modePath) TMURLPatternAll(@"ModeI", modePath)
#define TMURLPatternJ(modePath) TMURLPatternAll(@"ModeJ", modePath)

/// 一下部分是己方业务需求，一些使用频繁的字段KEY定义在头文件方便拿来使用
extern NSString *const MGJRouterParameterNavigation;


/// 全局会使用的block类型声明
typedef void(^MGJRouterVoidBlock)(void);
typedef void(^MGJRouterObjectBlock)(id objc);
typedef void(^MGJRouterObjectsBlock)(id objc1, id objc2);

@interface ModuleRouterManager : NSObject

// 这个类的主要负责URL注册和管理，目前有两种方式比较主流，一是在把注册代码分散到每一个控制器load方法里，二是现在这种使用单独的全局管理类去做，也可以分散到每个模块新建的管理类。
// 几乎所有的URL都可以在这里查询到，代码也会达到万行级别，不易维护，缺点很大。

@end
