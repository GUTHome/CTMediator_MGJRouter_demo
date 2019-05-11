//
//  Target_ModeD.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "Target_ModeD.h"
#import "TMModeDViewController.h"

@implementation Target_ModeD

- (UIViewController *)Action_createModeDViewController:(NSMutableDictionary *)params{
    TMModeDViewController *ModeD = [[TMModeDViewController alloc] init];
    ModeD.titleStr = params[@"titleStr"];
    ModeD.backImage = params[@"backImage"];
    ModeD.modeCBlock = params[@"callBlock"];
    return ModeD;
}

@end
