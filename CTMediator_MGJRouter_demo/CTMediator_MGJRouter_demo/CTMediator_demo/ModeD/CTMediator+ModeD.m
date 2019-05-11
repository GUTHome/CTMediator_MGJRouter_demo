//
//  CTMediator+ModeD.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator+ModeD.h"

//模块D内方便统一改
NSString * const kCTMediatorTargetName = @"ModeD";

@implementation CTMediator (ModeD)

- (UIViewController *)xxxNameTitle:(NSString *)title backImage:(UIImage *)backImage callBlock:(callBackBlock)callBlock{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"titleStr"] = title;
    params[@"backImage"] = backImage;
    params[@"callBlock"] = callBlock;
    return [self performTarget:kCTMediatorTargetName action:@"createModeDViewController" params:params shouldCacheTarget:YES];
}

@end
