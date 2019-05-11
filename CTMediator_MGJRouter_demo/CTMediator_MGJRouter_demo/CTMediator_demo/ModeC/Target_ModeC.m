//
//  Target_ModeC.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "Target_ModeC.h"
#import "TMModeCViewController.h"

@implementation Target_ModeC

- (UIViewController *)Action_createModeCViewController:(NSMutableDictionary *)params{
    TMModeCViewController *ModeC = [[TMModeCViewController alloc] init];
    ModeC.modeCBlock = params[@"modeCBlock"];
    return ModeC;
}

@end
