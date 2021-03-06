//
//  LXViewModel.m
//  LXMVVM
//
//  Created by 王明哲 on 16/1/8.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import "LXViewModel.h"

@interface LXViewModel ()

@property (nonatomic, strong, readwrite) id<LXViewModelServices> services;
@property (nonatomic, strong, readwrite) id params;

@end

@implementation LXViewModel

@synthesize services = _services;
@synthesize params   = _params;

@synthesize errors   = _errors;
@synthesize excutingSignal   = _excutingSignal;
@synthesize willDisappearSignal = _willDisappearSignal;
@synthesize shouldRequestRemoteDataOnViewDidLoad = _shouldRequestRemoteDataOnViewDidLoad;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LXViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel)
    [[viewModel
      rac_signalForSelector:@selector(initWithServices:params:)]
    	subscribeNext:^(id x) {
            @strongify(viewModel)
            [viewModel initialize];
        }];
    
    return viewModel;
}

- (instancetype)initWithServices:(id<LXViewModelServices>)viewModelServices params:(id)params {
    self = [super init];
    if (self) {
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        self.services = viewModelServices;
        self.params   = params;
    }
    return self;
}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACSubject *)excutingSignal {
    if (!_excutingSignal) _excutingSignal = [RACSubject subject];
    return _excutingSignal;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

- (void)initialize {}

@end
