//
//  CTMediator+ModeA.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator+ModeA.h"

@implementation CTMediator (ModeA)

- (UIViewController *)createModeAViewController{
    
    UIViewController *viewController = [self performTarget:@"ModeA" action:@"createModeAViewController" params:nil shouldCacheTarget:NO];
    return viewController;
}

// 模拟
- (UIViewController *)noTargetButShowViewController{
    
    // ModeA_AAA没有创建
    UIViewController *viewController = [self performTarget:@"ModeA_AAA" action:@"createModeAViewController" params:nil shouldCacheTarget:NO];
    return viewController;
}

- (UIViewController *)noMethodButShowViewController{
    
    // createModeAViewController_aaaaa 方法没有实现
    UIViewController *viewController = [self performTarget:@"ModeA" action:@"createModeAViewController_aaaaa" params:nil shouldCacheTarget:NO];
    return viewController;
}

@end
