//
//  ListPublishersResponseModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ListPublishersResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSArray *publishers;

@end
