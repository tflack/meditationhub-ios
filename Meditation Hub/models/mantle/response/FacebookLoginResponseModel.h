//
//  FacebookLoginResponseModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "UserModel.h"

@interface FacebookLoginResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *token;

@end
