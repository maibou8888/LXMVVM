//
//  LXModelServicesImpl.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/30.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "LXModelServicesImpl.h"

@implementation LXModelServicesImpl

-(RACSignal *)getSYCommentSiginalWithPage:(NSString *)page idString:(NSString *)idString {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    RACSignal *investSignal = [manager rac_GET:CombineURL(CommentURL) parameters:@{@"page":page,@"id":idString}];
    return [investSignal replayLazily];
}

-(RACSignal *)getjianceList {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    RACSignal *investSignal = [manager rac_GET:CombineURL(JianceURL) parameters:nil];
    return [investSignal replayLazily];
}

@end
