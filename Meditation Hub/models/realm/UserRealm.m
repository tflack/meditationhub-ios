//
//  UserRealm.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "UserRealm.h"
#import "UserModel.h"

@implementation UserRealm

- (id)initWithMantleModel:(UserModel *)userModel{
    self = [super init];
    if(!self) return nil;
    
    self.firstName = userModel.firstName;
    self.lastName = userModel.lastName;
    self.email = userModel.email;
    self.sessionToken = userModel.token;
    
    return self;
}

@end
