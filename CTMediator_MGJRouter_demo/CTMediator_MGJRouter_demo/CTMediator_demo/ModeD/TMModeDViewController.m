//
//  TMModeDViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMModeDViewController.h"

@interface TMModeDViewController ()

@end

@implementation TMModeDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.titleStr;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    imageV.image = self.backImage;
    imageV.center = self.view.center;
    [self.view addSubview:imageV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"title"] = @"来自ModeD的数据";
    dict[@"backImage"] = [UIImage imageNamed:@"backImage"];
    if (self.modeCBlock) {
        self.modeCBlock(dict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
