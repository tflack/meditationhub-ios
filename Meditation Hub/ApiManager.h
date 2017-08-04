#import "SessionManager.h"
#import "UserEmailLoginRequestModel.h"
#import "UserEmailLoginResponseModel.h"

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)postEmailLoginWithRequestModel:(UserEmailLoginRequestModel *)requestModel success:(void (^)(UserEmailLoginResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;

@end
