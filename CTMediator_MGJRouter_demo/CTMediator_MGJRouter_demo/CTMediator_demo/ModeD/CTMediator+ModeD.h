//
//  CTMediator+ModeD.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator.h"

/// 这个模块里的对外交互回调几乎都要写在这里

/// 1、ModeD 回调block
typedef void(^callBackBlock)(NSMutableDictionary *params);

@interface CTMediator (ModeD)

- (UIViewController *)xxxNameTitle:(NSString *)title backImage:(UIImage *)backImage callBlock:(callBackBlock)callBlock;

@end

