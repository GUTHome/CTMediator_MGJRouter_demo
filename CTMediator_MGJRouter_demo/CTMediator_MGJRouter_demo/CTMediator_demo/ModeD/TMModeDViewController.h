//
//  TMModeDViewController.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMBaseViewController.h"

typedef void(^callBackBlock)(NSMutableDictionary *params);

@interface TMModeDViewController : TMBaseViewController

//回调Block
@property (nonatomic, copy)callBackBlock modeCBlock;

//传值
@property (nonatomic, copy)NSString *titleStr;
@property (nonatomic, strong)UIImage *backImage;

@end
