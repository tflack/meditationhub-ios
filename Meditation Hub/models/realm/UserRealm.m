//
//  UserRealm.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "UserRealm.h"
#import "UserModel.h"
#import "ApiManager.h"

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

-(void)persistSessionToken:(NSString*)token {
    self.sessionToken = token;
    //Persist to the session manager.
    //We may want use https://realm.io/docs/objc/latest/api/Classes/RLMObject.html#/c:objc(cs)RLMObject(im)addNotificationBlock:
    //later to just detect changes and set them
    [[APIManager sharedManager] setSessionToken:token];
}

-(void)clearSessionToken {
    self.sessionToken = nil;
    //Persist to the session manager.
    //We may want use https://realm.io/docs/objc/latest/api/Classes/RLMObject.html#/c:objc(cs)RLMObject(im)addNotificationBlock:
    //later to just detect changes and set them
    [[APIManager sharedManager] clearSessionToken];
}

@end
