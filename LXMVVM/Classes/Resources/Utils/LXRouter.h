//
//  LXRouter.h
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewProtocol.h"

@protocol LXViewProtocol;

@interface LXRouter : NSObject

// Retrieves the shared router instance.
//
// Returns the shared router instance.
+ (instancetype)sharedInstance;

// Retrieves the view corresponding to the given view model.
//
// viewModel - The view model
//
// Returns the view corresponding to the given view model.
- (id<LXViewProtocol>)viewControllerForViewModel:(id<LXViewModelProtocol>)viewModel;

@end
