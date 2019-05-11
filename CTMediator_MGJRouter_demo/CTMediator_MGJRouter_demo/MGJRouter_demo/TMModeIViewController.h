//
//  TMModeIViewController.h
//  CTMediator_MGJRouter_demo
//
//  Created by cocomanber on 2019/5/4.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TMBaseViewController.h"

typedef void(^callBackBlock)(NSString *title, UIImage *backImage);

@interface TMModeIViewController : TMBaseViewController

@property (nonatomic, copy)callBackBlock backBlock;

@end

