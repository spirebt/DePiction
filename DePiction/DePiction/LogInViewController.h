//
//  LogInViewController.h
//  DePiction
//
//  Created by Spire Jankulovski on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "APICallsViewController.h"

@interface LogInViewController : UITableViewController <FBRequestDelegate,FBDialogDelegate,FBSessionDelegate>
{
    NSArray *contentForRow;
    NSArray *permissions;
    
    UIImageView *backgroundImageView;
    UIButton *loginButton;
    UITableView *menuTableView;
    
    NSMutableArray *mainMenuItems;
    
    UIView *headerView;
    UILabel *nameLabel;
    UIImageView *profilePhotoImageView;
    
    APICallsViewController *pendingApiCallsController;
}

@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UITableView *menuTableView;
@property (nonatomic, retain) NSMutableArray *mainMenuItems;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *profilePhotoImageView;
@property(nonatomic, strong)NSArray *contentForRow;
@end
