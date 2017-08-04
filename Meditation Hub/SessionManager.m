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

@end
