//
//  LDBusConnectorPtr.h
//  LDBusMediator
//  总控线挂接点协议
//  Created by 庞辉 on 4/14/16.
//  Copyright © 2016 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  LDBusConnectorPtr挂接点协议
 *
 *  每个业务模块在对外开放的挂接点实现这个协议，以便被BusMediator发现和调度
 */
@class LXViewModel;
@class LXViewController;
@protocol LXBusConnectorPrt <NSObject>

@optional

/**
 * 当前业务组件可导航的URL询问判断
 */
-(BOOL)canOpenURL:(nonnull NSURL *)URL;

/**
 * 业务模块挂接中间件，注册自己能够处理的URL，完成url的跳转；
 * 如果url跳转需要回传数据，则传入实现了数据接收的调用者；
 *  @param URL          跳转到的URL，通常为 productScheme://connector/relativePath
 *  @param params       伴随url的的调用参数
 */
- (nullable LXViewModel *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params;

/**
 * 通过viewModel映射出viewController
 * 实现此方法首先要实现connectToOpenURL:params:
 */
- (nullable LXViewController *)mapViewControllerWithViewModel:(nonnull LXViewModel *)viewModel URL:(nonnull NSURL *)URL;

/**
 * 业务模块挂接中间件，注册自己提供的service，实现服务接口的调用；
 * 
 * 通过protocol协议找到组件中对应的服务实现，生成一个服务单例；
 * 传递给调用者进行protocol接口中属性和方法的调用；
 */
- (nullable id)connectToHandleProtocol:(nonnull Protocol *)servicePrt;



@end

