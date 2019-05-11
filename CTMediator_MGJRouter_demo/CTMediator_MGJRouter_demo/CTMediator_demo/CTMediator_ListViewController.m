//
//  CTMediator_ListViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/2.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator_ListViewController.h"
#import "CTMediator+ModeA.h"
#import "CTMediator+ModeB.h"
#import "CTMediator+ModeC.h"
#import "CTMediator+ModeD.h"


@interface CTMediator_ListViewController ()

@end

@implementation CTMediator_ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

// 打开一个模块无传参无返回 = A
- (IBAction)action00:(id)sender {
    
    //注意在这里一定可以使得viewController ！= nil，可以修改源码，增加己方的业务
    //比如找不到Target对象时该统一返回一种类型VC提示Target错误相关信息展示
    //比如找不到Action对象时该统一返回一种类型VC提示Action错误相关信息展示
    //比如其他异常时该统一返回一种类型VC提示其他异常错误相关信息展示
    //总有一种VC返回来到这个，这样就少了很很多臃余的判断代码【个人见解】，详情看源码///注释
    UIViewController *viewController = [[CTMediator sharedInstance] createModeAViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 打开一个模块有传参无返回 = B
- (IBAction)action10:(id)sender {
    
    UIViewController *viewController = [[CTMediator sharedInstance] createModeBViewControllerWithTitle:@"模块B有传参无返回" backImage:[UIImage imageNamed:@"backImage"]];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 打开一个模块无传参有返回 = C
- (IBAction)action01:(id)sender {
    
    __weak __typeof(&*self)weakSelf = self;
    UIViewController *viewController = [[CTMediator sharedInstance] createModeCViewControllerWithCallBlock:^(NSMutableDictionary *params) {
        NSLog(@"\nModeC回调的参数：%@", params);
        weakSelf.navigationItem.title = params[@"title"]?:weakSelf.navigationItem.title;
    }];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 打开一个模块有传参有返回 = D
- (IBAction)action11:(id)sender {
    
    __weak __typeof(&*self)weakSelf = self;
    UIViewController *viewController = [[CTMediator sharedInstance] xxxNameTitle:@"模块D有传参有返回点击空白" backImage:[UIImage imageNamed:@"backImage"] callBlock:^(NSMutableDictionary *params) {
        NSLog(@"\nModeD回调的参数：%@", params);
        weakSelf.navigationItem.title = params[@"title"]?:weakSelf.navigationItem.title;
    }];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 模拟Target找不到的情况
- (IBAction)action_noTarget:(id)sender {
    
    UIViewController *viewController = [[CTMediator sharedInstance] noTargetButShowViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 模拟Method找不到的情况
- (IBAction)action_noMethod:(id)sender {
    
    UIViewController *viewController = [[CTMediator sharedInstance] noMethodButShowViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
