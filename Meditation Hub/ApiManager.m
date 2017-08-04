//
//  ApiManager.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "ApiManager.h"
#import "Mantle.h"

static NSString *const kUserEmailLoginPath = @"/auth/email";

@implementation APIManager

- (NSURLSessionDataTask *)postEmailLoginWithRequestModel:(UserEmailLoginRequestModel *)requestModel
                                              success:(void (^)(UserEmailLoginResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure{
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"X-Auth-Token"];
    
    return [self POST:kUserEmailLoginPath parameters:parametersWithKey progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 NSError *error;
                 UserEmailLoginResponseModel *loginResponse = [MTLJSONAdapter modelOfClass:UserEmailLoginResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(loginResponse);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 failure(error);
                 
             }];
}


@end
