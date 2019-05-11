//
//  TMModeCViewController.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/3.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMBaseViewController.h"

typedef void(^callBackBlock)(NSMutableDictionary *params);

@interface TMModeCViewController : TMBaseViewController

//回调Block
@property (nonatomic, copy)callBackBlock modeCBlock;

@end

