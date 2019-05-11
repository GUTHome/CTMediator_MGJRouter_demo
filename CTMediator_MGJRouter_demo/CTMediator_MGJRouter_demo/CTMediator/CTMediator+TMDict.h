//
//  CTMediator+TMDict.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (TMDict)

/// 扩展一个可变字典属性，方便创建控制器赋值时，减少创建字典的代码量。
@property (nonatomic, strong)NSMutableDictionary *params;

@end

/// 不可行，单例不会释放，会造成数据错乱或拿不到的情况。
/// 不可行，单例不会释放，会造成数据错乱或拿不到的情况。
/// 不可行，单例不会释放，会造成数据错乱或拿不到的情况。
