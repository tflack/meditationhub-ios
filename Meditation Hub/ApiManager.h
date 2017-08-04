#import "SessionManager.h"
#import "UserEmailLoginRequestModel.h"
#import "UserEmailLoginResponseModel.h"
#import "FacebookLoginRequestModel.h"
#import "FacebookLoginResponseModel.h"

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)postEmailLoginWithRequestModel:(UserEmailLoginRequestModel *)requestModel success:(void (^)(UserEmailLoginResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)postFacebookLoginWithRequestModel:(FacebookLoginRequestModel *)requestModel success:(void (^)(FacebookLoginResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;

@end
