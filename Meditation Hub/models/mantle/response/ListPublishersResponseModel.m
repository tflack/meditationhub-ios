//
//  ListPublishersResponseModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "ListPublishersResponseModel.h"
#import "PublisherModel.h"

@implementation ListPublishersResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"publishers" : @"items",
             @"success": @"success"
             };
}


+ (NSValueTransformer *)publishersJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:PublisherModel.class];
}

@end
