//
//  FirstDetailViewModel.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "FirstDetailViewModel.h"

@implementation FirstDetailViewModel

-(void)initialize {
    [super initialize];
}

-(instancetype)initWithServices:(id<LXViewModelServices>)viewModelServices params:(id)params {
    self = [super initWithServices:self.services params:params];
    if (self) {
        NSLog(@"详情页参数 --- %@",params);
    }
    return self;
}

@end
