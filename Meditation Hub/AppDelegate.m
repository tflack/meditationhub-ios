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
    
    
    //Set login vs. inside controller based on whether they are logged in.
    if([self hasValidSession]){
        NSLog(@"HAS VALID SESSION");
    }else{
        NSLog(@"No Valid Session");
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                        didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)hasValidSession {
    NSLog(@"Checking Session");
    //Do we have a session token stored?
    NSString *sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionToken"];
    if(sessionToken == nil){
        return NO;
    }else if(![self verifySession:sessionToken]){
       return NO;
    }
    return YES;
}

- (BOOL)verifySession:(NSString *)sessionToken {
    //Make the api call to verify the session
    return NO;
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
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
