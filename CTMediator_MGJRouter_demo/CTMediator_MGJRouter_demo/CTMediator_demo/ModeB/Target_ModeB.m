//
//  Target_ModeB.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "Target_ModeB.h"
#import "TMModeBViewController.h"

@implementation Target_ModeB

// 创建B控制器
-(UIViewController *)Action_createModeBViewController:(NSDictionary *)params{
    TMModeBViewController *ModeB = [[TMModeBViewController alloc] init];
    ModeB.titleStr = params[@"titleStr"];
    ModeB.backImage = params[@"backImage"];
    
    return ModeB;
}

@end
