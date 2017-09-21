//
//  UserRealm.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"
#import "UserModel.h"

@interface UserRealm : RLMObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property NSString *sessionToken;

- (id)initWithMantleModel:(UserModel *)userModel;

@end
