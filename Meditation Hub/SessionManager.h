//
//  SessionManager.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManager;
-(NSError *)handleError:(NSError *)error withSessionDataTask:(NSURLSessionDataTask *)dataTask;

@end
