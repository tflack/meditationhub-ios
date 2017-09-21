//
//  PublisherModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "UserModel.h"

@interface PublisherModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *shortDescription;
@property (nonatomic, copy) NSString *longDescription;
@property (nonatomic, copy) NSString *profilePhoto;
@property (nonatomic, copy) UserModel *user;

@end
