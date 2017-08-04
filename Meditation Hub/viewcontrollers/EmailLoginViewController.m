//
//  EmailLoginViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "EmailLoginViewController.h"
#import "UserEmailLoginRequestModel.h"
#import "ApiManager.h"
#import "UserRealm.h"

@interface EmailLoginViewController ()

@end

@implementation EmailLoginViewController

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

- (IBAction)loginClicked:(id)sender {
    UserEmailLoginRequestModel *requestModel = [UserEmailLoginRequestModel new];
    requestModel.email = _txtEmail.text;
    requestModel.password = _txtPassword.text;
    
    [[APIManager sharedManager] postEmailLoginWithRequestModel:requestModel success:^(UserEmailLoginResponseModel *responseModel){
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
        
        UIStoryboard *storyboard = self.storyboard;
        UIViewController *contentViewController;
        contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:contentViewController];
        
    } failure:^(NSError *error) {
        NSLog(@"FAILURE CALLING LOGIN API");
    }];
}

-(void)signinFinished {
    UIStoryboard *storyboard = self.storyboard;
    UIViewController *contentViewController;
    contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:contentViewController];
}
@end
