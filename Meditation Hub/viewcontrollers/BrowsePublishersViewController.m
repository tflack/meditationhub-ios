//
//  BrowsePublishersViewController.m
//  Meditation Hub
//
//  Created by Tim Flack on 9/11/17.
//  Copyright © 2017 MHUB. All rights reserved.
//

#import "BrowsePublishersViewController.h"
#import "ApiManager.h"
#import "ListPublishersRequestModel.h"
#import "ListPublishersResponseModel.h"

@interface BrowsePublishersViewController ()

@end

@implementation BrowsePublishersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPublishers];
}

-(void)loadPublishers {

    
    ListPublishersRequestModel *requestModel = [ListPublishersRequestModel new];
    
    [[APIManager sharedManager] listPublishers:requestModel success:^(ListPublishersResponseModel *responseModel){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                NSLog(@"listPublishers Response: %@", responseModel);
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self performSelector:@selector(signinFinished) withObject:nil afterDelay:2.0];
//                });
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"FAILURE CALLING FACEBOOK LOGIN API");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
