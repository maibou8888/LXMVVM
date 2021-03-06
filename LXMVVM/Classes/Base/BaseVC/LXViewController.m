//
//  LXViewController.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "LXViewController.h"
#import "LXViewModel.h"

#import "TWMessageBarManager.h"

@interface LXViewController ()

@property (nonatomic, strong, readwrite) LXViewModel *viewModel;
@end

@implementation LXViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LXViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (id<LXViewProtocol>)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)bindViewModel {
    
    //处理error
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        MRCError(error.localizedDescription);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
}

@end
