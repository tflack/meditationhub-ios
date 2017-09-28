//
//  LoginViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UserModel.h"
#import "UserRealm.h"
#import "FacebookLoginRequestModel.h"
#import "ApiManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    _loginLoadingViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginLoadingViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebookLoginButtonTapped:(id)sender {
    NSArray *permissionsArray = @[@"email"];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:permissionsArray fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            [self hideWaitOverlay:^(BOOL finished) {
                [self showLoginAlert:[error localizedDescription]];
            }];
        } else if (result.isCancelled) {
            [self hideWaitOverlay:^(BOOL finished) {
                [self showLoginAlert:@"Please accept the Facebook permission."];
            }];
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self facebookLoginAccepted];
            }else{
                [self hideWaitOverlay:^(BOOL finished) {
                    [self showLoginAlert:@"Something went wrong with Facebook login"];
                }];
            }
        }
    }];
}

-(void)facebookLoginAccepted{
    [self showWaitOverlay:^(BOOL finished) {
        NSString *token = [[FBSDKAccessToken currentAccessToken] tokenString];
        //Send the token to our server to create the account or auth the user
        FacebookLoginRequestModel *requestModel = [FacebookLoginRequestModel new];
        requestModel.facebookToken = token;
        
        [[APIManager sharedManager] postFacebookLoginWithRequestModel:requestModel success:^(FacebookLoginResponseModel *responseModel){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @autoreleasepool {
                    NSLog(@"Login Response: %@", responseModel);
                    //Remove the user
                    UserRealm *oldUserRealm = [[UserRealm allObjects] firstObject];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    if([[UserRealm allObjects] count] > 0){
                        [realm beginWriteTransaction];
                        [realm deleteObject:oldUserRealm];
                        [realm commitWriteTransaction];
                    }
                    
                    UserRealm *newUser = [[UserRealm alloc] initWithMantleModel:(UserModel *)responseModel.user];
                    newUser.sessionToken = responseModel.token;
                    [realm transactionWithBlock:^{
                        [realm addObject:newUser];
                    }];
                                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSelector:@selector(signinFinished) withObject:nil afterDelay:2.0];
                    });
                }
            });
        } failure:^(NSError *error) {
            NSLog(@"FAILURE CALLING FACEBOOK LOGIN API");
        }];
    }];
}

-(void)showLoginAlert:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Login In Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)processSignInResults:(UserModel *)userModel {
    //Do some things with the user modle maybe
}

-(void)signinFinished {
    [self hideWaitOverlay:^(BOOL hideComplete) {
        UIStoryboard *storyboard = self.storyboard;
        UIViewController *contentViewController;
        contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:contentViewController];
    }];
}

-(void)showWaitOverlay:(void(^)(BOOL))overlayComplete
{
    [self presentViewController:_loginLoadingViewController animated:YES completion:^{
        overlayComplete(YES);
    }];
}

-(void)hideWaitOverlay:(void(^)(BOOL))hideComplete
{
    [self dismissViewControllerAnimated:YES completion:^{
        hideComplete(YES);
    }];
}
@end
