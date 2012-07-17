//
//  LogInViewController.m
//  DePiction
//
//  Created by Spire Jankulovski on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"
#import "FBConnect.h"
#import "APICallsViewController.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
static NSString* kAppId = @"406381349412676";

@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize permissions;
@synthesize backgroundImageView;
@synthesize menuTableView;
@synthesize mainMenuItems;
@synthesize headerView;
@synthesize nameLabel;
@synthesize profilePhotoImageView;
@synthesize contentForRow;
@synthesize jsonData;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)displayComposerSheet

{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    
    
    [picker setSubject:@"Use Depiction"];
    
    /*
    
    // Set up the recipients.
    
    NSArray *toRecipients = [NSArray arrayWithObjects:@"first@example.com",
                             
                             nil];
    
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com",
                             
                             @"third@example.com", nil];
    
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"four@example.com",
                              
                              nil];
    
    
    
    [picker setToRecipients:toRecipients];
    
    [picker setCcRecipients:ccRecipients];
    
    [picker setBccRecipients:bccRecipients];
    
    
    
    // Attach an image to the email.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ipodnano"
                      
                                                     ofType:@"png"];
    
    NSData *myData = [NSData dataWithContentsOfFile:path];
    
    [picker addAttachmentData:myData mimeType:@"image/png"
     
                     fileName:@"ipodnano"];
    
    
    */
    // Fill out the email body text.
    
    NSString *emailBody = @"Ajmo ovde link do app";
    
    [picker setMessageBody:emailBody isHTML:NO];
    
    
    
    // Present the mail composition interface.
    
    if (picker != nil) {
        [self presentModalViewController:picker animated:YES];    
    }
}



// The mail compose view controller delegate method

- (void)mailComposeController:(MFMailComposeViewController *)controller

          didFinishWithResult:(MFMailComposeResult)result

                        error:(NSError *)error

{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
    
    //post to server

    
     NSURL *url = [NSURL URLWithString:@"http://virtualcarmods.com/DEV/SHOOTUP/dbmanipulation/dbmanipulation.php?function=insert"];
     ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
     
    [request setPostValue:@"mile malio" forKey:@"user"];
    [request setPostValue:@"125kljf15468" forKey:@"token"];
    
    //ovde goce proverva i vraka vrednosti - ako e prv pat, default broj na coins freez i bombs - vraka bombs freez coins statistic error success
    
    [request setPostValue:@"cel grad|15*i drugite gradoj|28" forKey:@"friends"];
    [request setPostValue:@"10" forKey:@"coins"];
    [request setPostValue:@"10" forKey:@"freez"];
    [request setPostValue:@"1" forKey:@"bombs"];
    [request setPostValue:@"some statistics" forKey:@"statistics"];
     

    [request setDelegate:self];
     //[request setUploadProgressDelegate:myProgressIndicator];
    [request startAsynchronous];
     //NSLog(@"Value: %f",[myProgressIndicator progress]);

     
     
     
     
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data

    NSString *responseString = [request responseString];
    SBJSON *jsonReader = [SBJSON new];
    jsonData = [jsonReader objectWithString:responseString error:nil];

    NSLog(@"JSON %@",jsonData);
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}  
- (void)apiGraphUserPermissions {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}


#pragma - Private Helper Methods

/**
 * Show the logged in menu
 */

- (void)showLoggedIn {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.backgroundImageView.hidden = YES;
    loginButton.hidden = YES;
    emailButton.hidden = YES;
    self.menuTableView.hidden = NO;
    
    [self apiFQLIMe];
}

/**
 * Show the logged in menu
 */

- (void)showLoggedOut {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //self.menuTableView.hidden = YES;
    self.backgroundImageView.hidden = NO;
    loginButton.hidden = NO;
    emailButton.hidden = NO;
    
    // Clear personal info
    nameLabel.text = @"";
    // Get the profile image
    [profilePhotoImageView setImage:nil];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

/**
 * Show the authorization dialog.
 */
- (void)login {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        [[delegate facebook] authorize:permissions];
    } else {
        [self showLoggedIn];
        

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] 
            && [defaults objectForKey:@"FBExpirationDateKey"]) {
            [delegate facebook].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            [delegate facebook].expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        if (![[delegate facebook] isSessionValid]) {
            [[delegate facebook] authorize:nil];
        }
        

        
        // Override point for customization after application launch.
        // Add the navigation controller's view to the window and display.
        
        
        // Check App ID:
        // This is really a warning for the developer, this should not
        // happen in a completed app
        if (!kAppId) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Setup Error"
                                      message:@"Missing app ID. You cannot run the app until you provide this in the code."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil,
                                      nil];
            [alertView show];
        } else {
            // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
            // be opened, doing a simple check without local app id factored in here
            NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
            BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
            NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
            if ([aBundleURLTypes isKindOfClass:[NSArray class]] &&
                ([aBundleURLTypes count] > 0)) {
                NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
                if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                    NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                    if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                        ([aBundleURLSchemes count] > 0)) {
                        NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                        if ([scheme isKindOfClass:[NSString class]] &&
                            [url hasPrefix:scheme]) {
                            bSchemeInPlist = YES;
                        }
                    }
                }
            }
            // Check if the authorization callback will work
            BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
            if (!bSchemeInPlist || !bCanOpenUrl) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Setup Error"
                                          message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,
                                          nil];
                [alertView show];
            }
        }
    }
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
}

/**
 * Helper method called when a menu button is clicked
 */
- (void)menuButtonClicked:(id)sender {
    /*
     
     UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     button.frame = CGRectMake(20, 20, (cell.contentView.frame.size.width-40), 44);
     button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
     [button setBackgroundImage:[[UIImage imageNamed:@"MenuButton.png"]
     stretchableImageWithLeftCapWidth:9 topCapHeight:9]
     forState:UIControlStateNormal];
     [button setTitle:[mainMenuItems objectAtIndex:indexPath.row]
     forState:UIControlStateNormal];
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
     button.tag = indexPath.row;
     [cell.contentView addSubview:button];
     cell.textLabel.text = [mainMenuItems objectAtIndex:[indexPath row]];

     
     */
    // Each menu button in the UITableViewController is initialized
    // with a tag representing the table cell row. When the button
    // is clicked the button is passed along in the sender object.
    // From this object we can then read the tag property to determine
    // which menu button was clicked.
    APICallsViewController *controller = [[APICallsViewController alloc]
                                          initWithIndex:[sender tag]];
    pendingApiCallsController = controller;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - View lifecycle
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    
    // Initialize permissions
    permissions = [[NSArray alloc] initWithObjects:@"offline_access", nil];
    
    // Main menu items
    mainMenuItems = [[NSMutableArray alloc] initWithCapacity:1];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *apiInfo = [[delegate apiData] apiConfigData];
    for (NSUInteger i=0; i < [apiInfo count]; i++) {
        [mainMenuItems addObject:[[apiInfo objectAtIndex:i] objectForKey:@"title"]];
    }
    contentForRow = [NSArray arrayWithObjects:@"Statr Game", nil];

    // Set up the view programmatically
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"DePiction for iOS";
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil];
    
    // Background Image
    backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    [backgroundImageView setImage:[UIImage imageNamed:@"Default.png"]];
    //[backgroundImageView setAlpha:0.25];
    [self.view addSubview:backgroundImageView];
    
    // Login Button
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat xLoginButtonOffset = self.view.center.x - (318/2);
    CGFloat yLoginButtonOffset = self.view.bounds.size.height - (58 + 13);
    loginButton.frame = CGRectMake(xLoginButtonOffset,yLoginButtonOffset,318,58);
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal@2x.png"]forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed@2x.png"]forState:UIControlStateHighlighted];
    [loginButton sizeToFit];
    [self.view addSubview:loginButton];
    
    emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //CGFloat xemailButtonOffset = self.view.center.x - (600/2);
    //CGFloat yemailButtonOffset = self.view.bounds.size.height - (58 + 13);
    emailButton.frame = CGRectMake(0,100,318,58);
    [emailButton addTarget:self action:@selector(displayComposerSheet) forControlEvents:UIControlEventTouchUpInside];
    [emailButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal@2x.png"]forState:UIControlStateNormal];
    [emailButton setImage:[UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed@2x.png"]forState:UIControlStateHighlighted];
    [emailButton sizeToFit];
    [self.view addSubview:emailButton];
    
    // Main Menu Table
    menuTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [menuTableView setBackgroundColor:[UIColor whiteColor]];
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    menuTableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    menuTableView.dataSource = self;
    menuTableView.delegate = self;
    menuTableView.hidden = YES;
    //[self.view addSubview:menuTableView];
    
    // Table header
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    headerView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    headerView.backgroundColor = [UIColor whiteColor];
    CGFloat xProfilePhotoOffset = self.view.center.x - 25.0;
    profilePhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xProfilePhotoOffset, 20, 50, 50)];
    profilePhotoImageView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [headerView addSubview:profilePhotoImageView];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 20.0)];
    nameLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.text = @"";
    [headerView addSubview:nameLabel];
    menuTableView.tableHeaderView = headerView;
    
    [self.view addSubview:menuTableView];
    
    pendingApiCallsController = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        [self showLoggedOut];
    } else {
        [self showLoggedIn];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return [mainMenuItems count];
    return [contentForRow count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //create the button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 20, (cell.contentView.frame.size.width-40), 44);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [button setBackgroundImage:[[UIImage imageNamed:@"MenuButton.png"]
                                stretchableImageWithLeftCapWidth:9 topCapHeight:9]
                      forState:UIControlStateNormal];
    [button setTitle:[contentForRow objectAtIndex:indexPath.row]
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexPath.row;
    [cell.contentView addSubview:button];
   // cell.textLabel.text = [contentForRow objectAtIndex:[indexPath row]];

       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self showLoggedIn];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[delegate facebook] accessToken] expiresAt:[[delegate facebook] expirationDate]];
    
    [pendingApiCallsController userDidGrantPermission];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
   // NSLog(@"received response %@",response);
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        // If basic information callback, set the UI objects to
        // display this.
        [nameLabel setText:[result objectForKey:@"name"]];
        // Get the profile image
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
        
        // Resize, crop the image to make sure it is square and renders
        // well on Retina display
        float ratio;
        float delta;
        float px = 100; // Double the pixels of the UIImageView (to render on Retina)
        CGPoint offset;
        CGSize size = image.size;
        if (size.width > size.height) {
            ratio = px / size.width;
            delta = (ratio*size.width - ratio*size.height);
            offset = CGPointMake(delta/2, 0);
        } else {
            ratio = px / size.height;
            delta = (ratio*size.height - ratio*size.width);
            offset = CGPointMake(0, delta/2);
        }
        CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                     (ratio * size.width) + delta,
                                     (ratio * size.height) + delta);
        UIGraphicsBeginImageContext(CGSizeMake(px, px));
        UIRectClip(clipRect);
        [image drawInRect:clipRect];
        UIImage *imgThumb = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [profilePhotoImageView setImage:imgThumb];
        
        [self apiGraphUserPermissions];
    } else {
        // Processing permissions information
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}
#pragma mark - Table view delegate



@end
