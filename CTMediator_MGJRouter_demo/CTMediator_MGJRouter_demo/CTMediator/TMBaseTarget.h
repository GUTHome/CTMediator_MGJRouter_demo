//
//  TMBaseTarget.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//  备用基类方便统一处理异常情况
//  可以根据传进来的模块字符串处理不同展示结果
//

#import <Foundation/Foundation.h>

@interface TMBaseTarget : NSObject

/// 找不到Target统一实现
- (UIViewController *)notFoundTarget:(id)params;

/// 找到Target，但找不到方法，统一实现
- (UIViewController *)notFoundMethod:(id)params;

/// 其他异常统一实现【方法名不重要】
- (UIViewController *)notFoundParams:(id)params;

@end

