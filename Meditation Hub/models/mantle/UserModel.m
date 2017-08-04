//
//  UserModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"firstName": @"firstName",
             @"lastName": @"lastName",
             @"email": @"email"
             };
}

@end
