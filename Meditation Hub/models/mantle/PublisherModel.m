//
//  PublisherModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "PublisherModel.h"

@implementation PublisherModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"shortDescription": @"description_short",
             @"longDescription": @"description_long",
             @"profilePhoto": @"profile_photo"
             };
}

@end
