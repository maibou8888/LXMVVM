//
//  LDMediator.m
//  LDBusMediator
//
//  Created by 庞辉 on 4/8/16.
//  Copyright © 2016 casa. All rights reserved.
//

#import "LXBusMediator.h"
#import "LXViewModel.h"
#import "LXViewController.h"

NSString* const kLDRouteViewControllerKey = @"LDRouteViewController";
NSString *__nonnull const kLDRouteModeKey = @"kLDRouteType";

//全部保存各个模块的connector实例
static NSMutableDictionary<NSString *, id<LXBusConnectorPrt>> *g_connectorMap = nil;


@implementation LXBusMediator

#pragma mark - 向总控制中心注册挂接点

+(void)registerConnector:(nonnull id<LXBusConnectorPrt>)connector{
    if (![connector conformsToProtocol:@protocol(LXBusConnectorPrt)]) {
        return;
    }

    @synchronized(g_connectorMap) {
        if (g_connectorMap == nil){
            g_connectorMap = [[NSMutableDictionary alloc] initWithCapacity:5];
        }

        NSString *connectorClsStr = NSStringFromClass([connector class]);
        if ([g_connectorMap objectForKey:connectorClsStr] == nil) {
            [g_connectorMap setObject:connector forKey:connectorClsStr];
        }
    }
}


#pragma mark - 页面跳转接口

//判断某个URL能否导航
+(BOOL)canRouteURL:(nonnull NSURL *)URL{
    if(!g_connectorMap || g_connectorMap.count <= 0) return NO;

    __block BOOL success = NO;
    //遍历connector不能并发
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<LXBusConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
        if([connector respondsToSelector:@selector(canOpenURL:)]){
            if ([connector canOpenURL:URL]) {
                success = YES;
                *stop = YES;
            }
        }
    }];

    return success;
}


+(BOOL)routeURL:(nonnull NSURL *)URL{
    return [self routeURL:URL withParameters:nil];
}


+(BOOL)routeURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params{
    if(!g_connectorMap || g_connectorMap.count <= 0) return NO;

    __block BOOL success = NO;
    __block int queryCount = 0;
    NSDictionary *userParams = [self userParametersWithURL:URL andParameters:params];
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<LXBusConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
        queryCount++;
        if([connector respondsToSelector:@selector(connectToOpenURL:params:)]){
            id returnObj = [connector connectToOpenURL:URL params:userParams];
            if(returnObj && [returnObj isKindOfClass:[LXViewModel class]]){
                if ([returnObj class] == [LXViewModel class]){
                    success = YES;
                    
                } else {
                    NavigationMode mode = NavigationModeNone;
                    mode = params[kLDRouteModeKey]?[params[kLDRouteModeKey] intValue]:NavigationModePush;
                    
                    switch (mode) {
                        case NavigationModePush: {
                            [LXDelegate.services pushViewModel:returnObj animated:YES];
                        }
                            break;
                            
                        case NavigationModePresent: {
                            [LXDelegate.services presentViewModel:returnObj animated:YES completion:nil];
                        }
                            break;
                            
                        case NavigationModeDismiss: {
                            [LXDelegate.services dismissViewModelAnimated:YES completion:nil];
                        }
                            break;
                            
                        default:
                            break;
                    }
                    success = YES;
                }

                *stop = YES;
            }
        }
    }];

    return success;
}


+(nullable LXViewModel *)viewModelForURL:(nonnull NSURL *)URL{
    return [self viewModelForURL:URL withParameters:nil];
}


+(nullable LXViewModel *)viewModelForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params{
    if(!g_connectorMap || g_connectorMap.count <= 0) return nil;

    __block LXViewModel *returnObj = nil;
    __block int queryCount = 0;
    NSDictionary *userParams = [self userParametersWithURL:URL andParameters:params];
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<LXBusConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
        queryCount++;
        if([connector respondsToSelector:@selector(connectToOpenURL:params:)]){
            returnObj = [connector connectToOpenURL:URL params:userParams];
            if(returnObj && [returnObj isKindOfClass:[LXViewModel class]]){
                *stop = YES;
            }
        }
    }];


    if (returnObj) {
        if([returnObj class] == [LXViewModel class]){
            return nil;
        } else {
            return returnObj;
        }
    }

    return nil;
}

+(LXViewController *)viewControllerForURL:(NSURL *)URL {
    if(!g_connectorMap || g_connectorMap.count <= 0) return nil;

    LXViewModel *viewModel = [LXBusMediator viewModelForURL:URL];
    
    if (viewModel && [viewModel isKindOfClass:[LXViewModel class]]) {
        __block LXViewController *returnObj = nil;
        [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<LXBusConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
            if([connector respondsToSelector:@selector(mapViewControllerWithViewModel:URL:)]){
                returnObj = [connector mapViewControllerWithViewModel:viewModel URL:URL];
                if(returnObj && [returnObj isKindOfClass:[LXViewController class]]){
                    *stop = YES;
                }
            }
        }];
        
        if (returnObj) {
            if([returnObj class] == [LXViewController class]){
                return nil;
            } else {
                return returnObj;
            }
        }
        
        return nil;
    }
    
    return nil;
}

/**
 * 从url获取query参数放入到参数列表中
 */
+(NSDictionary *)userParametersWithURL:(nonnull NSURL *)URL andParameters:(nullable NSDictionary *)params{
    NSArray *pairs = [URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *userParams = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *key = [kv objectAtIndex:0];
            NSString *value = [self URLDecodedString:[kv objectAtIndex:1]];
            [userParams setObject:value forKey:key];
        }
    }
    [userParams addEntriesFromDictionary:params];
    return [NSDictionary dictionaryWithDictionary:userParams];
}


/**
 * 对url的value部分进行urlDecoding
 */
+(nonnull NSString *)URLDecodedString:(nonnull NSString *)urlString
{
    NSString *result = urlString;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                       (__bridge CFStringRef)urlString,CFSTR(""),kCFStringEncodingUTF8);
#else
    result = [urlString stringByRemovingPercentEncoding];
#endif
    return result;
}


#pragma mark - 服务调用接口

+(nullable id)serviceForProtocol:(nonnull Protocol *)protocol{
    if(!g_connectorMap || g_connectorMap.count <= 0) return nil;

    __block id returnServiceImp = nil;
    [g_connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<LXBusConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
        if([connector respondsToSelector:@selector(connectToHandleProtocol:)]){
            returnServiceImp = [connector connectToHandleProtocol:protocol];
            if(returnServiceImp){
                *stop = YES;
            }
        }
    }];

    return returnServiceImp;
}

@end
