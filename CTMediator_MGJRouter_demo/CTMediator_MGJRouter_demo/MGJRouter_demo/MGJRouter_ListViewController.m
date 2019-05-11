//
//  MGJRouter_ListViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/2.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "MGJRouter_ListViewController.h"

@interface MGJRouter_ListViewController ()

@property (nonatomic, copy)MGJRouterObjectsBlock objectsBlock;

@end

@implementation MGJRouter_ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

// 打开一个模块无传参无返回
- (IBAction)action00:(id)sender {
    
    [MGJRouter openURL:TMURLPatternE(@"Push_TMModeEViewController") withUserInfo:@{MGJRouterParameterNavigation:self.navigationController} completion:nil];
}

// 打开一个模块有传参无返回
- (IBAction)action10:(id)sender {
    
    [MGJRouter openURL:TMURLPatternF(@"Push_TMModeFViewController") withUserInfo:@{MGJRouterParameterNavigation:self.navigationController, @"title":@"ModeF标题", @"backImage":[UIImage imageNamed:@"backImage"]} completion:nil];
}

// 打开一个模块无传参有返回
- (IBAction)action01:(id)sender {
    
    /// 注意block实现在传参前，避免为nil或被过滤掉
    self.objectsBlock = ^(NSString *objc1, UIImage *objc2) {
        NSLog(@"---> %@  %@", objc1, objc2);
    };
    [MGJRouter openURL:TMURLPatternI(@"Push_TMModeIViewController") withUserInfo:@{MGJRouterParameterNavigation:self.navigationController, @"block":self.objectsBlock} completion:nil];
}

// 打开一个模块有传参有返回
- (IBAction)action11:(id)sender {
    
    self.objectsBlock = ^(NSString *objc1, UIImage *objc2) {
        NSLog(@"---> %@  %@", objc1, objc2);
    };
    
    // 这里尽量使用set方法做防空安全判断!!!
    NSDictionary *params = @{
                             MGJRouterParameterNavigation:self.navigationController,
                             @"block":self.objectsBlock,
                             @"title":@"ModeF标题",
                             @"backImage":[UIImage imageNamed:@"backImage"]
                             };

    [MGJRouter openURL:TMURLPatternJ(@"Push_TMModeJViewController") withUserInfo:params completion:nil];
    
}

// Pressent-get：拿ModeE模块测试
- (IBAction)actionE:(id)sender {
    
    // viewController 实际是[TMModeEViewController class] 在这里对viewController操作的就就需要import发生耦合了。模块之间不建议这么做!!!
    UIViewController *viewController = [MGJRouter objectForURL:TMURLPatternE(@"Pressent_TMModeEViewController")];
    Class namea = NSClassFromString(@"TMModeEViewController");
    if (viewController && [viewController isKindOfClass:namea]) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        viewController.view.backgroundColor = [UIColor orangeColor];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

// 找不到路由的回调
- (IBAction)action30:(id)sender {
    
    // Push_TMModeEViewController_register这个路径没有注册到
    [MGJRouter openURL:TMURLPatternE(@"Push_TMModeEViewController_register") withUserInfo:@{MGJRouterParameterNavigation:self.navigationController} completion:nil];
}

@end
