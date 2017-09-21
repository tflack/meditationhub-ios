//
//  ListPublishersRequestModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "ListPublishersRequestModel.h"

@implementation ListPublishersRequestModel MTLModel <MTLJSONSerializing>

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"page": @"page",
             @"pageSize": @"pageSize", 
             };

@end
