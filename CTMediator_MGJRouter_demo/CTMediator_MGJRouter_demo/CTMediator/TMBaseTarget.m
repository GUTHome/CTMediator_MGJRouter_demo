//
//  TMBaseTarget.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMBaseTarget.h"
#import "TMBaseViewController.h"

@implementation TMBaseTarget

/// 找不到Target统一实现
- (UIViewController *)notFoundTarget:(id)params{
    
    TMBaseViewController *ModeA = [[TMBaseViewController alloc] init];
    ModeA.view.backgroundColor = [UIColor purpleColor];
    ModeA.navigationItem.title = @"解析出错啦，找不到Target";
    return ModeA;
}

/// 找到Target，但找不到Method，统一实现
- (UIViewController *)notFoundMethod:(id)params{
    
    TMBaseViewController *ModeA = [[TMBaseViewController alloc] init];
    ModeA.view.backgroundColor = [UIColor purpleColor];
    ModeA.navigationItem.title = @"解析出错啦，找不到Method";
    return ModeA;
}

/// 其他异常统一实现【方法名不重要】
- (UIViewController *)notFoundParams:(id)params{
    
    TMBaseViewController *ModeA = [[TMBaseViewController alloc] init];
    ModeA.view.backgroundColor = [UIColor purpleColor];
    ModeA.navigationItem.title = @"解析出错啦，出现异常";
    return ModeA;
}

@end
