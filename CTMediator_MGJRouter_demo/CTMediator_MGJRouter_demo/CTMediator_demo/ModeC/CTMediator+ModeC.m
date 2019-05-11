//
//  CTMediator+ModeC.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator+ModeC.h"

@implementation CTMediator (ModeC)

- (UIViewController *)createModeCViewControllerWithCallBlock:(callBackBlock)backBlock{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"modeCBlock"] = backBlock;
    return [self performTarget:@"ModeC" action:@"createModeCViewController" params:params shouldCacheTarget:YES];
}

@end
