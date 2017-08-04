//
//  FacebookLoginRequestModel.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "FacebookLoginRequestModel.h"

@implementation FacebookLoginRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"facebookToken": @"facebook_token"
             };
}
@end
