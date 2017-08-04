//
//  WelcomeViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UserRealm.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserRealm *userRealm = [[UserRealm allObjects] firstObject];
    _lblWelcomee.text = [NSString stringWithFormat:@"Welcome %@",[userRealm valueForKey:@"firstName"]];
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
