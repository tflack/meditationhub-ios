//
//  LogoutViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/11/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "LogoutViewController.h"
#import "UserRealm.h"
#import "ApiManager.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            UserRealm *currentUser = [[UserRealm allObjects] firstObject];
            RLMRealm *realm = [RLMRealm defaultRealm];
            if([[UserRealm allObjects] count] > 0){
                [realm beginWriteTransaction];
                [realm deleteObject:currentUser];
                [realm commitWriteTransaction];
            }
            [[APIManager sharedManager] clearSessionToken];
            dispatch_async(dispatch_get_main_queue(), ^{
                //Go to login
                [self performSelector:@selector(controllerTransition) withObject:self afterDelay:2.0f];
            });
        }
    });
}

-(void)controllerTransition {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    self.view.window.rootViewController = vc;
    [self.view.window makeKeyAndVisible];
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

@end
