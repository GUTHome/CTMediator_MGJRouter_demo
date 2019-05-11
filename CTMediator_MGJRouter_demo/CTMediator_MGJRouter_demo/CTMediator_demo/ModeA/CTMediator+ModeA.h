//
//  CTMediator+ModeA.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//  暴露给其他组件提供调用的统一披露API，这里的方法命名不需要遵守什么特殊规则，按照己方工程代码规范即可
//

#import "CTMediator.h"

@interface CTMediator (ModeA)

// 创建A控制器
- (UIViewController *)createModeAViewController;

//模拟
- (UIViewController *)noTargetButShowViewController;
- (UIViewController *)noMethodButShowViewController;

@end



