//
//  LoginViewController.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/3/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *processingActivityView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;
@property (weak, nonatomic) IBOutlet UILabel *waitingMessage;


- (IBAction)facebookLoginButtonTapped:(id)sender;


@end
