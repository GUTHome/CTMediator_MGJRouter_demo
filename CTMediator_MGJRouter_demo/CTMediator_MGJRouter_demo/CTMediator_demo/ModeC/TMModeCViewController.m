//
//  TMModeCViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMModeCViewController.h"

@interface TMModeCViewController ()

@end

@implementation TMModeCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"点击空白处回调参数测试";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"title"] = @"来自ModeC的数据";
    dict[@"backImage"] = [UIImage imageNamed:@"backImage"];
    if (self.modeCBlock) {
        self.modeCBlock(dict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
