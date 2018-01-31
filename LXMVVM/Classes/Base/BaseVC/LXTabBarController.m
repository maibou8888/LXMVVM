//
//  MRCTabBarController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "LXTabBarController.h"

@interface LXTabBarController ()

@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;

@end

@implementation LXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.frame = self.view.bounds;

    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
}

@end
