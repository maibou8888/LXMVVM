//
//  LXNavigationControllerStack.h
//  LXMVVM
//
//  Created by 王明哲 on 16/1/9.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXViewModelServices;

@interface LXNavigationControllerStack : NSObject

//用service创建LXNavigationControllerStack
- (instancetype)initWithServices:(id<LXViewModelServices>)services;

//push & pop UINavigationController
- (void)pushNavigationController:(UINavigationController *)navigationController;
- (UINavigationController *)popNavigationController;

@end
