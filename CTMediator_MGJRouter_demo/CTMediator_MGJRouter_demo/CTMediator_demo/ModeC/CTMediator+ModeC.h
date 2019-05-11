//
//  CTMediator+ModeC.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator.h"

/// 这个模块里的对外交互回调几乎都要写在这里

/// 1、ModeC 回调block
typedef void(^callBackBlock)(NSMutableDictionary *params);


@interface CTMediator (ModeC)

- (UIViewController *)createModeCViewControllerWithCallBlock:(callBackBlock)backBlock;

@end


