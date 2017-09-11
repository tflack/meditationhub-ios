//
//  WelcomeViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UserRealm.h"
#import "WelcomeViewController.h"
#import <MMDrawerController.h>
#import "MMNavigationController.h"
#import "MMLeftSideDrawerViewController.h"

@interface WelcomeViewController ()
@property (nonatomic,strong) MMDrawerController * drawerController;
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

-(void)determineSegue {
    //This will invariably run a few operations to determin
    //Which controller this user should see based on
    //if they have subscriptions, etc...
    //For now lets just go to the package list
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * leftSideDrawerViewController = [[MMLeftSideDrawerViewController alloc] init];
    UIViewController * centerViewController = [storyboard instantiateViewControllerWithIdentifier:@"packageListViewController"];
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    
    [navigationController setRestorationIdentifier:@"MMCenterNavigationControllerRestorationKey"];
    UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideNavController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
//    [self.drawerController
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
    //self.view.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    UIColor * tintColor = [UIColor colorWithRed:124.0/255.0
//                                          green:53.0/255.0
//                                           blue:139.0/255.0
//                                          alpha:1.0];
//    [self.view.window setTintColor:tintColor];
    self.view.window.rootViewController = self.drawerController;
    [[UIApplication sharedApplication].keyWindow setRootViewController:self.drawerController];
}

- (IBAction)tappedNextButton:(id)sender {
    [self determineSegue];
}
@end
