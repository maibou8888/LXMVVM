//
//  LXViewModelServices.h
//  LXMVVM
//
//  Created by 王明哲 on 16/1/8.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXModelServicesImpl.h"

typedef void (^VoidBlock)();

@protocol LXViewModelProtocol;

@protocol LXViewModelServices <NSObject>

//model的service
@property (nonatomic, strong, readonly) id<LXModelServices> modelServices;

//视图之间的导航
- (void)pushViewModel:(id<LXViewModelProtocol>)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(id<LXViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

- (void)resetRootViewModel:(id<LXViewModelProtocol>)viewModel;


@end
