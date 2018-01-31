//
//  LXViewProtocol.h
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXViewModelProtocol;

@protocol LXViewProtocol <NSObject>

@required

//绑定viewModel
- (instancetype)initWithViewModel:(id<LXViewModelProtocol>)viewModel;

//当前视图的viewModel
@property (nonatomic, strong, readonly) id<LXViewModelProtocol> viewModel;

@optional

//绑定方法
- (void)bindViewModel;

@end
