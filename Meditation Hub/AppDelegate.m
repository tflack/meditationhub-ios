//
//  AppDelegate.m
//  Meditation Hub
//
//  Created by Tim Flack on 6/23/17.
//  Copyright © 2017 Homma. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKApplicationDelegate.h>
#import <AFNetworking/AFNetworking.h>
#import "UserRealm.h"
#import "ApiManager.h"
#import "CurrentUserRequestModel.h"
#import "CurrentUserResponseModel.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    
    //Colors
    UIColor *navBarTintandTextColor = [UIColor colorWithRed:0.075 green:0.608 blue:0.918 alpha:1.000];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navBarTintandTextColor, NSForegroundColorAttributeName, [UIFont fontWithName:@"FontName" size:16.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:navBarTintandTextColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self hasValidSession:^(BOOL sessionValid) {
        if(!sessionValid){
            [self.window.rootViewController.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"vclLoading"];
            self.window.rootViewController = vc;
            [self.window makeKeyAndVisible];
        }
    }];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self hasValidSession:^(BOOL sessionValid) {
        if(!sessionValid){
            [self.window.rootViewController.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
            self.window.rootViewController = vc;
            [self.window makeKeyAndVisible];
        }
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)hasValidSession:(void (^)(BOOL sessionValid))completionHandler{
    NSLog(@"Checking Session");
    if([[UserRealm allObjects] count] > 0){
        //getCurrentUser attempts to get the current user and includes the auth token in it's header so we don't need to do anything with the
        //UserRealm value here
        CurrentUserRequestModel *requestModel = [CurrentUserRequestModel new];
        [[APIManager sharedManager] getCurrentUser:requestModel success:^(CurrentUserResponseModel *responseModel){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(responseModel.success){
                    completionHandler(YES);
                }else{
                    completionHandler(NO);
                }
            });
        } failure:^(NSError *error) {
            if([error.userInfo objectForKey:@"auth_failed"]){
                //Plain old auth failed
                NSLog(@"Auth Failed");
            }else{
                //Some other problem, should probably log it
                NSLog(@"Some other error");
            }
            completionHandler(NO);
        }];
    }else{
        completionHandler(NO);
    }
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"MMCenterNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftSideDrawerController"]){
        UIViewController * leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if([leftVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)leftVC topViewController];
        }
        else {
            return leftVC;
        }
        
    }
    return nil;
}


@end
