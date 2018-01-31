//
//  Connector_B.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "Connector_B.h"
#import "SecondViewModel.h"
#import "SecondViewController.h"

@implementation Connector_B

+(void)load{
    @autoreleasepool{
        [LXBusMediator registerConnector:[self sharedConnector]];
    }
}

+(nonnull Connector_B *)sharedConnector{
    static Connector_B *_sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConnector = [[Connector_B alloc] init];
    });
    
    return _sharedConnector;
}

#pragma mark - LDBusConnectorPrt
-(BOOL)canOpenURL:(nonnull NSURL *)URL{
    if ([URL.host isEqualToString:@"BB"]) {
        return YES;
    }
    
    return NO;
}

- (nullable LXViewModel *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params{
    if ([URL.host isEqualToString:@"BB"]) {
        SecondViewModel *viewModel = [[SecondViewModel alloc] initWithServices:LXDelegate.services params:params];
        return viewModel;
    }
    
    return nil;
}

-(LXViewController *)mapViewControllerWithViewModel:(LXViewModel *)viewModel URL:(nonnull NSURL *)URL {
    if ([URL.host isEqualToString:@"BB"]) {
        SecondViewController *secondVC = [[SecondViewController alloc] initWithViewModel:viewModel];
        return secondVC;
    }
    return nil;
}

@end
