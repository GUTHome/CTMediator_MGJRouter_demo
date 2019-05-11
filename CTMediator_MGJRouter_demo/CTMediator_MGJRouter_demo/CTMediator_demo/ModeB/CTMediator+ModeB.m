//
//  CTMediator+ModeB.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator+ModeB.h"

@implementation CTMediator (ModeB)

//入口方式创建B控制器
- (UIViewController *)createModeBViewControllerWithTitle:(NSString *)title backImage:(UIImage *)backImage{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"titleStr"] = title;
    params[@"backImage"] = backImage;
    return [self performTarget:@"ModeB" action:@"createModeBViewController" params:params shouldCacheTarget:NO];
}

@end
