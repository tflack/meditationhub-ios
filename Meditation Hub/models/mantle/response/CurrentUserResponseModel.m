//
//  CurrentUserLoginResponseModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/9/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "CurrentUserResponseModel.h"
#import "UserModel.h"

@implementation CurrentUserResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"message" : @"message",
             @"user" : @"user",
             @"success": @"success"
             };
}


+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UserModel.class];
}

@end
