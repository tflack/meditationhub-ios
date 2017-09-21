//
//  ApiManager.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "ApiManager.h"
#import "Mantle.h"
#import "UserRealm.h"

static NSString *const kUserEmailLoginPath = @"/auth/email";
static NSString *const kFacebookLoginPath = @"/auth/facebook";
static NSString *const kCurrentUserPath = @"/user/me";

@implementation APIManager

- (NSURLSessionDataTask *)postEmailLoginWithRequestModel:(UserEmailLoginRequestModel *)requestModel
                                              success:(void (^)(UserEmailLoginResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure{
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"X-Auth-Token"];
    
    return [self POST:kUserEmailLoginPath parameters:parametersWithKey progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 NSError *error;
                 UserEmailLoginResponseModel *loginResponse = [MTLJSONAdapter modelOfClass:UserEmailLoginResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(loginResponse);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 failure([self handleError:error withSessionDataTask:task]);
             }];
}


- (NSURLSessionDataTask *)postFacebookLoginWithRequestModel:(FacebookLoginRequestModel *)requestModel
                                                 success:(void (^)(FacebookLoginResponseModel *responseModel))success
                                                 failure:(void (^)(NSError *error))failure{
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"X-Auth-Token"];
    
    return [self POST:kFacebookLoginPath parameters:parametersWithKey progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  
                  NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                  
                  NSError *error;
                  FacebookLoginResponseModel *loginResponse = [MTLJSONAdapter modelOfClass:FacebookLoginResponseModel.class
                                                                         fromJSONDictionary:responseDictionary error:&error];
                  success(loginResponse);
                  
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  failure([self handleError:error withSessionDataTask:task]);
                  
              }];
}

- (NSURLSessionDataTask *)getCurrentUser:(CurrentUserRequestModel *)requestModel
                                                    success:(void (^)(CurrentUserResponseModel *responseModel))success
                                                    failure:(void (^)(NSError *error))failure{
    
//    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
//    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
//    
    UserRealm *userRealm = [[UserRealm allObjects] firstObject];
    [self.requestSerializer setValue:[userRealm valueForKey:@"sessionToken"] forHTTPHeaderField:@"X-Auth-Token"];
    
    return [self GET:kCurrentUserPath parameters:nil progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  
                  NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                  
                  NSError *error;
                  CurrentUserResponseModel *response = [MTLJSONAdapter modelOfClass:CurrentUserResponseModel.class
                                                                        fromJSONDictionary:responseDictionary error:&error];
                  success(response);
                  
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  failure([self handleError:error withSessionDataTask:task]);
              }];
}


@end
