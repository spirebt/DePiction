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
#import "ASIHTTPRequest.h"
#import <MessageUI/MessageUI.h>
@interface LogInViewController : UITableViewController <FBRequestDelegate,FBDialogDelegate,FBSessionDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    NSArray *contentForRow;
    NSArray *permissions;
    
    UIImageView *backgroundImageView;
    UIButton *loginButton;
    UIButton *emailButton;
    UITableView *menuTableView;
    
    
    UIView *headerView;
    UILabel *nameLabel;
    UIImageView *profilePhotoImageView;
    
    APICallsViewController *pendingApiCallsController;
    NSMutableArray *mainMenuItems;
    
}
@property (nonatomic, retain) NSMutableArray *mainMenuItems;
@property (strong, nonatomic) NSMutableArray *jsonData;

@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UITableView *menuTableView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *profilePhotoImageView;
@property(nonatomic, strong)NSArray *contentForRow;
-(void)displayComposerSheet;

@end
