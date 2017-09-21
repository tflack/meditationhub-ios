//
//  CurrentUserLoginResponseModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 9/9/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CurrentUserResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;

@end
