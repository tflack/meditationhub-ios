//
//  User.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "UserEmailLoginRequestModel.h"

@implementation UserEmailLoginRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"email": @"email",
             @"password": @"password"
             };
}

@end
