//
//  JianceListModel.h
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JianceListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic , strong) NSArray  *jianceList;

@end

@interface JianceModel : MTLModel <MTLJSONSerializing>

@property (nonatomic , strong) NSString *jianceName;

@end
