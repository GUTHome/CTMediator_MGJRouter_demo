//
//  ModuleRouterManager.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/4.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "ModuleRouterManager.h"
#import "MGJRouter.h"

/// 一下部分是己方业务需求，一些使用频繁的字段KEY定义在头文件方便拿来使用
NSString *const MGJRouterParameterNavigation = @"MGJRouterParameterNavigation";


/// 这里会引入一系列h文件，因为需要创建控制器和对控制器做一些操作。
/// 弊端很大，会把一些h文件的共享给别的模块。
#import "TMModeEViewController.h"
#import "TMModeFViewController.h"
#import "TMModeIViewController.h"
#import "TMModeJViewController.h"

@implementation ModuleRouterManager

+ (void)load{
    
    // 处理未注册的需求
    [MGJRouter routeUnregisterURLHandler:^(NSString *routerURL) {
        
        NSLog(@"未注册的url: %@", routerURL);
    }];
    
    // modeE组件-无传值无返回
    [MGJRouter registerURLPattern:TMURLPatternE(@"Push_TMModeEViewController") toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *nav = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterNavigation];
        TMModeEViewController *vc = [[TMModeEViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }];
    
    // modeF组件-有传值无返回
    [MGJRouter registerURLPattern:TMURLPatternF(@"Push_TMModeFViewController") toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *nav = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterNavigation];
        TMModeFViewController *vc = [[TMModeFViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.titleStr = routerParameters[MGJRouterParameterUserInfo][@"title"];
        vc.backImage = routerParameters[MGJRouterParameterUserInfo][@"backImage"];
        
        [nav pushViewController:vc animated:YES];
    }];
    
    // modeI组件-无传值有返回
    [MGJRouter registerURLPattern:TMURLPatternI(@"Push_TMModeIViewController") toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *nav = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterNavigation];
        TMModeIViewController *vc = [[TMModeIViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.backBlock = routerParameters[MGJRouterParameterUserInfo][@"block"];
        
        [nav pushViewController:vc animated:YES];
    }];
    
    // modeJ组件-有传值有返回
    [MGJRouter registerURLPattern:TMURLPatternJ(@"Push_TMModeJViewController") toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *nav = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterNavigation];
        TMModeJViewController *vc = [[TMModeJViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.titleStr = routerParameters[MGJRouterParameterUserInfo][@"title"];
        vc.backImage = routerParameters[MGJRouterParameterUserInfo][@"backImage"];
        vc.backBlock = routerParameters[MGJRouterParameterUserInfo][@"block"];
        
        [nav pushViewController:vc animated:YES];
    }];
    
    // Pressent-get：拿ModeE模块测试
    [MGJRouter registerURLPattern:TMURLPatternE(@"Pressent_TMModeEViewController") toObjectHandler:^id(NSDictionary *routerParameters) {
        TMModeEViewController *vc = [[TMModeEViewController alloc] init];
        return vc;
    }];
}

@end
