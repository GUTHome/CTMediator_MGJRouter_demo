//
//  TMModeIViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/4.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMModeIViewController.h"

@interface TMModeIViewController ()

@end

@implementation TMModeIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"来自ModeI-请点击空白处";
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (self.backBlock) {
        self.backBlock(@"|来自ModeI的数据|", [UIImage imageNamed:@"backImage"]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
