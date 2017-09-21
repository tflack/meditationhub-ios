//
//  FacebookLoginResponseModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "FacebookLoginResponseModel.h"
#import "UserModel.h"

@class UserModel;

@implementation FacebookLoginResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"message" : @"message",
             @"token" : @"token",
             @"user" : @"user",
             @"success": @"success"
             };
}


+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UserModel.class];
}

@end
