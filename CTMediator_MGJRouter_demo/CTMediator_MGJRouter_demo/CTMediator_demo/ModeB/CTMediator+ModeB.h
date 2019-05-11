//
//  CTMediator+ModeB.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ModeB)

//入口方式创建B控制器
- (UIViewController *)createModeBViewControllerWithTitle:(NSString *)title backImage:(UIImage *)backImage;

@end
