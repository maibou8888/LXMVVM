//
//  JianceListModel.m
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#import "JianceListModel.h"

@implementation JianceListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"jianceList"  : @"data",
             };
}

@end

@implementation JianceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"jianceName"  : @"srtc_name",
             };
}

+ (NSValueTransformer *)recordListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JianceModel class]];
}
@end
