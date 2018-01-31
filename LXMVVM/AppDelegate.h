//
//  AppDelegate.h
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXNavigationControllerStack.h"

@protocol LXViewModelServices;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) id<LXViewModelServices> services;
@property (nonatomic, strong, readonly) LXNavigationControllerStack *navigationControllerStack;

@end

