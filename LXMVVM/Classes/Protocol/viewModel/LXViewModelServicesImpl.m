//
//  LXViewModelServicesImpl.m
//  LXMVVM
//
//  Created by 王明哲 on 16/1/8.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import "LXViewModelServicesImpl.h"

@interface LXViewModelServicesImpl ()

@end

@implementation LXViewModelServicesImpl
@synthesize modelServices = _modelServices;

- (instancetype)init {
    self = [super init];
    if (self) {
        _modelServices = [[LXModelServicesImpl alloc] init];
    }
    return self;
}

- (void)pushViewModel:(id<LXViewModelProtocol>)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(id<LXViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(id<LXViewModelProtocol>)viewModel {}

@end
