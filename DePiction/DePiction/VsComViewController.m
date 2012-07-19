//
//  VsComViewController.m
//  DePiction
//
//  Created by Spire Jankulovski on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VsComViewController.h"
#import "AppDelegate.h"
#import "SBJSON.h"
#import "GameViewController.h"

@interface VsComViewController ()

@end

@implementation VsComViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    [super viewDidLoad];


    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    categoryNames = [NSMutableDictionary dictionary];
   // NSLog(@"%@",[[jsonData valueForKey:@"categories"] valueForKey:@"cattitle"]);
    
    for (int i = 0; i< [[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"id"]count];i++) {
        [categoryNames setObject:[[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"cattitle"]objectAtIndex:i] forKey:[[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"id"]objectAtIndex:i]];

    }

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

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return [mainMenuItems count];
    return [[categoryNames allKeys] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellStr = [[categoryNames allValues] objectAtIndex:[indexPath row]];
    cellTag = [[[categoryNames allKeys] objectAtIndex:[indexPath row]] intValue];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.opaque = NO;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 20, (cell.contentView.frame.size.width-40), 44);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [button setBackgroundImage:[[UIImage imageNamed:@"MenuButton.png"]
                                stretchableImageWithLeftCapWidth:9 topCapHeight:9]
                      forState:UIControlStateNormal];
    [button setTitle:cellStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getImages:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = cellTag;
    [cell.contentView addSubview:button];
    
    //cell.textLabel.text = cellStr;
    // Configure the cell...
    
    return cell;
}
-(void)getImages:(id)sender{
    UIButton *button = (UIButton *)sender;
    //GO To next View With tag as category ID
    NSString *categoryIdfromTag = [NSString stringWithFormat:@"%d",[button tag]];
    GameViewController *controller = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];

    controller.categoryId = categoryIdfromTag;
    [self.navigationController pushViewController:controller animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",cellTag);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
