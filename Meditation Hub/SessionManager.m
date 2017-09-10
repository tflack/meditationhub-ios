//
//  SessionManager.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "SessionManager.h"
#import "Global.h"

@implementation SessionManager

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    if(!self) return nil;
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return self;
}

+ (id)sharedManager {
    static SessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

-(NSError *)handleError:(NSError *)error withSessionDataTask:(NSURLSessionDataTask *)dataTask {
    NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
    userInfo[@"auth_failed"] = @NO;
    
    NSInteger statusCode = [(NSHTTPURLResponse *)dataTask.response statusCode];
    if (statusCode != 200) {
        NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
        if(statusCode == 403){
            NSLog(@"Auth Failed");
            userInfo[@"auth_failed"] = @YES;
        }
    }
    
    return [NSError errorWithDomain:error.domain code:error.code userInfo:[userInfo copy]];;
}
@end
