//
//  CTMediator+TMDict.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator+TMDict.h"
#import <objc/runtime.h>

static const void *CTMediatorParamsKey = &CTMediatorParamsKey;

@implementation CTMediator (TMDict)

- (void)setParams:(NSMutableDictionary *)params{
     objc_setAssociatedObject(self, CTMediatorParamsKey, params,  OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)params{
    NSMutableDictionary *dict = (NSMutableDictionary *)objc_getAssociatedObject(self, CTMediatorParamsKey);
    if (dict.count) {
        return dict;
    }
    dict = [NSMutableDictionary dictionary];
    [self setParams:dict];
    return dict;
}

@end
