//
//  ListPublishersRequestModel.h
//  Meditation Hub
//
//  Created by Tim Flack on 9/21/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ListPublishersRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *pageSize;
@end
