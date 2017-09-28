#import "SessionManager.h"
#import "UserEmailLoginRequestModel.h"
#import "UserEmailLoginResponseModel.h"
#import "FacebookLoginRequestModel.h"
#import "FacebookLoginResponseModel.h"
#import "CurrentUserResponseModel.h"
#import "CurrentUserRequestModel.h"
#import "ListPublishersRequestModel.h"
#import "ListPublishersResponseModel.h"

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)postEmailLoginWithRequestModel:(UserEmailLoginRequestModel *)requestModel success:(void (^)(UserEmailLoginResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)postFacebookLoginWithRequestModel:(FacebookLoginRequestModel *)requestModel success:(void (^)(FacebookLoginResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *)getCurrentUser:(CurrentUserRequestModel *)requestModel success:(void (^)(CurrentUserResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)listPublishers:(ListPublishersRequestModel *)requestModel success:(void (^)(ListPublishersResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;



@end
