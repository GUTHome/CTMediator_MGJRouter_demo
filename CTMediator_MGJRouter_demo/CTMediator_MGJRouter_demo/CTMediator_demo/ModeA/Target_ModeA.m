//
//  Target_ModeA.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "Target_ModeA.h"
#import "TMModeAViewController.h"

@implementation Target_ModeA

-(UIViewController *)Action_createModeAViewController{
    TMModeAViewController *ModeA = [[TMModeAViewController alloc] init];
    return ModeA;
}

@end
