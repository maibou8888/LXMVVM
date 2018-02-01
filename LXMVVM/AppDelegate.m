//
//  AppDelegate.m
//  LXMVVM
//
//  Created by 王明哲 on 16/1/8.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewModel.h"
#import "LXViewModelServicesImpl.h"

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) LXNavigationControllerStack *navigationControllerStack;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.services = [[LXViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[LXNavigationControllerStack alloc] initWithServices:self.services];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //settings
    [self configureAppearance];
    [self configureHighVersion];
    [self.services resetRootViewModel:[self createInitialViewModel]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (id<LXViewModelProtocol>)createInitialViewModel {
    return [[HomePageViewModel alloc] initWithServices:self.services params:nil];
}

- (void)configureAppearance {
    //背景色
    [UINavigationBar appearance].barTintColor = tabbarColor;
    
    //黑色背景 白色文字
    [UINavigationBar appearance].barStyle  = UIBarStyleBlack;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f],
                                                         NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)configureHighVersion {
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

@end
