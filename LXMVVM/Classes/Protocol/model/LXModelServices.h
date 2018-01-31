//
//  LXModelServices.h
//  LXMVVM
//
//  Created by 王明哲 on 16/1/14.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXModelServices <NSObject>

-(RACSignal *)getSYCommentSiginalWithPage:(NSString *)page idString:(NSString *)idString;

-(RACSignal *)getjianceList;

@end
