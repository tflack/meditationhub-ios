//
//  WelcomeViewController.h
//  Meditation Hub
//
//  Created by Tim Flack on 8/4/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblWelcomee;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)tappedNextButton:(id)sender;

@end
