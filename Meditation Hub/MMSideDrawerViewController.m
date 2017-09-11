// Copyright (c) 2013 Mutual Mobile (http://mutualmobile.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "MMSideDrawerViewController.h"
#import "PackageListViewController.h"
#import "MMSideDrawerTableViewCell.h"
#import "MMSideDrawerSectionHeaderView.h"
#import "MMLogoView.h"
#import "MMNavigationController.h"
#import "UserRealm.h"
#import "Global.h"

@implementation MMSideDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self.tableView setBackgroundColor:LEFT_DRAWER_BACKGROUND_COLOR];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view setBackgroundColor:LEFT_DRAWER_BACKGROUND_COLOR];

    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]){
        [self.navigationController.navigationBar setBarTintColor:LEFT_DRAWER_BACKGROUND_COLOR];
    }
    else {
        [self.navigationController.navigationBar setTintColor:LEFT_DRAWER_BACKGROUND_COLOR];
    }


    NSDictionary *navBarTitleDict;
    navBarTitleDict = @{NSForegroundColorAttributeName:LEFT_DRAWER_BACKGROUND_COLOR};
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleDict];
    
//    CGSize logoSize = CGSizeMake(58, 62);
//    MMLogoView * logo = [[MMLogoView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.tableView.bounds)-logoSize.width/2.0,
//                                                                     -logoSize.height-logoSize.height/4.0,
//                                                                     logoSize.width,
//                                                                     logoSize.height)];
//    [logo setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
//    [self.tableView addSubview:logo];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections-1)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)contentSizeDidChange:(NSString *)size{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case MMDrawerSectionMyMeditations:
            return 3;
        case MMDrawerSectionBrowse:
            return 2;
        case MMDrawerSectionAccount:
            return 2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    switch (indexPath.section) {
        case MMDrawerSectionMyMeditations:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Packages"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Subscriptions"];
                    break;
                case 2:
                    [cell.textLabel setText:@"Favorites"];
                    break;
                default:
                    break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        case MMDrawerSectionBrowse:{
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Packages"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Publishers"];
                    break;
                default:
                    break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        }
        case MMDrawerSectionAccount:{
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Settings"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Logout"];
                    break;
                default:
                    break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case MMDrawerSectionMyMeditations:
            return @"My Meditations";
        case MMDrawerSectionBrowse:
            return @"Discover";
        case MMDrawerSectionAccount:
            return @"Account";
        default:
            return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MMSideDrawerSectionHeaderView * headerView;
    headerView =  [[MMSideDrawerSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 56.0)];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [headerView setTitle:[tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 56.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    switch (indexPath.section) {
        case MMDrawerSectionMyMeditations:{
            NSString *controllerIdentifier;
            switch (indexPath.row) {
                case 0:
                    NSLog(@"SELECTED PACKAGES");
                    controllerIdentifier = @"packageListViewController";
                    break;
                case 1:
                    NSLog(@"SELECTED SUBSCRIPTIONS");
                    controllerIdentifier = @"subscriptionsViewController";
                    break;
                case 2:
                    NSLog(@"SELECTED FAVORITES");
                    controllerIdentifier = @"favoritesViewController";
                    break;
                default:
                    break;
            }
            
            UIViewController * center = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
            UINavigationController * nav = [[MMNavigationController alloc] initWithRootViewController:center];
            
            [self.mm_drawerController
                              setCenterViewController:nav
                              withCloseAnimation:YES
                              completion:nil];
            
            
            //DIFFFERENT ANIMATION
            //                [self.mm_drawerController
            //                 setCenterViewController:nav
            //                 withFullCloseAnimation:YES
            //                 completion:nil];
            
            break;
        }
        case MMDrawerSectionBrowse:{
            NSString *controllerIdentifier;
            switch (indexPath.row) {
                case 0:
                    NSLog(@"SELECTED PACKAGES");
                    controllerIdentifier = @"browsePackagesViewController";
                    break;
                case 1:
                    NSLog(@"SELECTED SUBSCRIPTIONS");
                    controllerIdentifier = @"browsePublishersViewController";
                    break;
                default:
                    break;
            }
            
            UIViewController * center = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
            UINavigationController * nav = [[MMNavigationController alloc] initWithRootViewController:center];
            
            [self.mm_drawerController
             setCenterViewController:nav
             withCloseAnimation:YES
             completion:nil];
            
            
            //DIFFFERENT ANIMATION
            //                [self.mm_drawerController
            //                 setCenterViewController:nav
            //                 withFullCloseAnimation:YES
            //                 completion:nil];
            
            break;
        }
        case MMDrawerSectionAccount:{
            NSString *controllerIdentifier;
            switch (indexPath.row) {
                case 0:
                    NSLog(@"SELECTED SETTINGS");
                    controllerIdentifier = @"settingsViewController";
                    break;
                case 1:
                    NSLog(@"SELECTED LOGOUT");
                    controllerIdentifier = @"logoutViewController";
                    break;
                default:
                    break;
            }
            
            UIViewController * center = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
            UINavigationController * nav = [[MMNavigationController alloc] initWithRootViewController:center];
            
            [self.mm_drawerController
             setCenterViewController:nav
             withCloseAnimation:YES
             completion:nil];
            
            break;
        }
        default:
            break;
    }
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
