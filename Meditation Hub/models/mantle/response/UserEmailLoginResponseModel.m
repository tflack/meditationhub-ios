//
//  UserEmailLoginResponseModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "UserEmailLoginResponseModel.h"
@class UserModel;

@implementation UserEmailLoginResponseModel

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
