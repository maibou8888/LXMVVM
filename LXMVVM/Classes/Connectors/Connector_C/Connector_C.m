//
//  Connector_C.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "Connector_C.h"
#import "ThirdViewModel.h"
#import "ThirdViewController.h"

@implementation Connector_C

+(void)load{
    @autoreleasepool{
        [LXBusMediator registerConnector:[self sharedConnector]];
    }
}

+(nonnull Connector_C *)sharedConnector{
    static Connector_C *_sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConnector = [[Connector_C alloc] init];
    });
    
    return _sharedConnector;
}

#pragma mark - LDBusConnectorPrt
-(BOOL)canOpenURL:(nonnull NSURL *)URL{
    if ([URL.host isEqualToString:@"CC"]) {
        return YES;
    }
    
    return NO;
}

- (nullable LXViewModel *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params{
    if ([URL.host isEqualToString:@"CC"]) {
        ThirdViewModel *viewModel = [[ThirdViewModel alloc] initWithServices:LXDelegate.services params:params];
        return viewModel;
    }
    
    return nil;
}

-(LXViewController *)mapViewControllerWithViewModel:(LXViewModel *)viewModel URL:(nonnull NSURL *)URL {
    if ([URL.host isEqualToString:@"CC"]) {
        ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithViewModel:viewModel];
        return thirdVC;
    }
    return nil;
}

@end
