//
//  LoginViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
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
            [self performSelectorOnMainThread:@selector(hideWaitOverlay) withObject:nil waitUntilDone:YES];
            [login logOut];
            [self showLoginAlert:[error localizedDescription]];
        } else if (result.isCancelled) {
            [self performSelectorOnMainThread:@selector(hideWaitOverlay) withObject:nil waitUntilDone:YES];
            //DDLogVerbose(@"The user cancelled the Facebook login.");
            [self showLoginAlert:@"Please accept the Facebook permission."];
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self facebookLoginAccepted];
            }else{
                //DDLogVerbose(@"User did not grant all permissions");
                [self showLoginAlert:[error localizedDescription]];
            }
        }
    }];
}

-(void)facebookLoginAccepted{
    [self showWaitOverlay:@"Please Wait..." withCompletionBlock:^(BOOL finished) {
        NSString *token = [[FBSDKAccessToken currentAccessToken] tokenString];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name,last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             }
             
             //Send the token to our server to create the account or auth the user
             FacebookLoginRequestModel *requestModel = [FacebookLoginRequestModel new];
             requestModel.facebookToken = token;
             requestModel.firstName = result[@"first_name"];
             requestModel.lastName = result[@"last_name"];
             requestModel.email = result[@"email"];
             
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
                             [self signinFinished];
                         });
                     }
                 });
             } failure:^(NSError *error) {
                 NSLog(@"FAILURE CALLING FACEBOOK LOGIN API");
             }];
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
    UIStoryboard *storyboard = self.storyboard;
    UIViewController *contentViewController;
    BOOL hasMenu = YES;
//    if([loginData objectForKey:@"vehicles"] != nil){
//        NSDictionary *vehicleData = [loginData objectForKey:@"vehicles"];
//        if (vehicleData == (id)[NSNull null] || [vehicleData count]==0){
//            contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"signupNoVehiclesViewController"];
//            hasMenu = NO;
//        }else{
//            for (NSDictionary* vehicleDict in vehicleData) {
//                if([vehicleDict objectForKey:@"beacons"] != nil){
//                    if([[vehicleDict objectForKey:@"beacons"] count] > 0){
//                        foundBeacons = YES;
//                        break;
//                    }
//                }
//            }
//            
//            if(![CLLocationManager locationServicesEnabled]){
//                contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"locationServicesViewController"];
//                hasMenu = NO;
//            }else if ([CLLocationManager locationServicesEnabled] &&
//                      [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
//                contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"locationServicesViewController"];
//                hasMenu = NO;
//            }else if ([CLLocationManager locationServicesEnabled] &&
//                      [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
//                contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"locationServicesViewController"];
//                hasMenu = NO;
//            }else{
//                if(foundBeacons){
//                    contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"beaconTrackerView"];
//                }else{
//                    contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"driverAuditTrackerView"];
//                }
//            }
//        }
//    }else{
        contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
        hasMenu = NO;
    //}
    
    [self performSelectorOnMainThread:@selector(hideWaitOverlay) withObject:nil waitUntilDone:YES];
    //Only load the reveal menu controller if we need to
//    if(hasMenu){
//        SidebarViewController *menuViewController = (SidebarViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
//        if( [loginData objectForKey:@"userdata"] != nil){
//            NSDictionary *userData = [loginData objectForKey:@"userdata"];
//            if([userData objectForKey:@"picture"] != nil){
//                menuViewController.avatarUrl = [userData objectForKey:@"picture"];
//            }
//            if( [userData objectForKey:@"date_created"] != nil){
//                menuViewController.memberDate = [userData objectForKey:@"date_created"];
//            }
//            if( [userData objectForKey:@"firstname"] != nil && [userData objectForKey:@"lastname"] != nil){
//                menuViewController.userName = [NSString stringWithFormat:@"%@ %@", [userData objectForKey:@"firstname"], [userData objectForKey:@"lastname"]];
//            }
//        }
//        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:contentViewController];
//        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
//                                                        initWithRearViewController:menuViewController frontViewController:frontNavigationController];
//        
//        [mainRevealController setShouldUseFrontViewOverlay:YES];
//        
//        self.view.window.rootViewController = mainRevealController;
//        [[UIApplication sharedApplication].keyWindow setRootViewController:mainRevealController];
//    }else{
        [[UIApplication sharedApplication].keyWindow setRootViewController:contentViewController];
        //[self presentViewController:contentViewController animated:YES completion:nil];
//    }
}

-(void)showWaitOverlay:(NSString *)message withCompletionBlock:(void(^)(BOOL))overlayComplete
{
    [_processingActivityView setAlpha:0.0f];
    [_waitingMessage setText:message];
    [_processingActivityView setHidden:NO];
    [_activitySpinner startAnimating];
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_processingActivityView setAlpha:1.0f];
                     }
                     completion:^(BOOL finished){
                         dispatch_async(dispatch_get_main_queue(), ^{
                             overlayComplete(YES);
                         });
                     }];
}

-(void)hideWaitOverlay
{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_processingActivityView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         [_activitySpinner stopAnimating];
                         [_processingActivityView setHidden:YES];
                     }];
}
@end
