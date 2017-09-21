//
//  FacebookLoginRequestModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FacebookLoginRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *facebookToken;

@end
