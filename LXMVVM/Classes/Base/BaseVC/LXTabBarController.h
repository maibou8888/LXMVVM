//
//  MRCTabBarController.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "LXViewProtocol.h"
#import "LXViewController.h"

@interface LXTabBarController : LXViewController

@property (nonatomic, strong, readonly) UITabBarController *tabBarController;

@end
