//
//  TMModeFViewController.m
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/4.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMModeFViewController.h"

@interface TMModeFViewController ()

@end

@implementation TMModeFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.titleStr;;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    imageV.image = self.backImage;
    imageV.center = self.view.center;
    [self.view addSubview:imageV];
}

@end
