//
//  LXViewModelProtocol.h
//  LXMVVM
//
//  Created by 王明哲 on 16/1/8.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXViewModelServices;

@protocol LXViewModelProtocol <NSObject>

@required

//初始化viewModelServices,后面为参数
- (instancetype)initWithServices:(id<LXViewModelServices>)viewModelServices params:(id)params;

@property (nonatomic, strong, readonly) id<LXViewModelServices> services;
@property (nonatomic, strong, readonly) id params;

@optional

//errorSignal
@property (nonatomic, strong, readonly) RACSubject *errors;

//excutingSignal
@property (nonatomic, strong, readonly) RACSubject *excutingSignal;

// viewWillDisappear signal
@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

//Request Remote Data On ViewDidLoad
@property (nonatomic, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

//viewModel binding method
- (void)initialize;

@end
