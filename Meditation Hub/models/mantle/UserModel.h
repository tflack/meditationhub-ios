//
//  UserModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email;

@end
