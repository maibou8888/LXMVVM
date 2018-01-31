//
//  Connector_A.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "Connector_A.h"
#import "FirstViewModel.h"
#import "FirstDetailViewModel.h"
#import "FirstViewController.h"

@implementation Connector_A

+(void)load{
    @autoreleasepool{
        [LXBusMediator registerConnector:[self sharedConnector]];
    }
}

+(nonnull Connector_A *)sharedConnector{
    static Connector_A *_sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConnector = [[Connector_A alloc] init];
    });
    
    return _sharedConnector;
}

#pragma mark - LDBusConnectorPrt
-(BOOL)canOpenURL:(nonnull NSURL *)URL{
    if ([URL.host isEqualToString:@"AA"] || [URL.host isEqualToString:@"AA_Detail"]) {
        return YES;
    }
    
    return NO;
}

- (nullable LXViewModel *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params{
    if ([URL.host isEqualToString:@"AA"]) {
        FirstViewModel *viewModel = [[FirstViewModel alloc] initWithServices:LXDelegate.services params:params];
        return viewModel;
        
    }else if ([URL.host isEqualToString:@"AA_Detail"]) {
        FirstDetailViewModel *viewModel = [[FirstDetailViewModel alloc] initWithServices:LXDelegate.services params:params];
        return viewModel;
    }
    
    return nil;
}

-(LXViewController *)mapViewControllerWithViewModel:(LXViewModel *)viewModel URL:(nonnull NSURL *)URL {
    if ([URL.host isEqualToString:@"AA"]) {
        FirstViewController *firstVC = [[FirstViewController alloc] initWithViewModel:viewModel];
        return firstVC;
    }
    return nil;
}

@end
