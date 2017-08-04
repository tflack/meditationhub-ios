//
//  User.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserEmailLoginRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

@end
