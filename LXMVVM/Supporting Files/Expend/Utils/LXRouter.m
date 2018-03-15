//
//  LXRouter.m
//  LXMVVM
//
//  Created by 王明哲 on 16/1/9.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import "LXRouter.h"

static LXRouter *_sharedInstance = nil;

@interface LXRouter ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings; // viewModel到view的映射

@end

@implementation LXRouter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
}

- (id<LXViewProtocol>)viewControllerForViewModel:(id<LXViewModelProtocol>)viewModel {
    NSString *viewController = [self.viewModelViewMappings valueForKey:NSStringFromClass(((NSObject *)viewModel).class)];
    
    NSParameterAssert([NSClassFromString(viewController) conformsToProtocol:@protocol(LXViewProtocol)]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    return @{
             @"FirstViewModel"      : @"FirstViewController",
             @"SecondViewModel"     : @"SecondViewController",
             @"ThirdViewModel"      : @"ThirdViewController",
             @"HomePageViewModel"   : @"LXHomePageViewController",
             @"FirstDetailViewModel": @"FirstDetailViewController",
             };
}

@end

