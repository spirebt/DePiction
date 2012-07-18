//
//  GameViewController.m
//  DePiction
//
//  Created by Spire Jankulovski on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "JSON.h"
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize categoryId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://thepaperwall.com/appadmin/alljson/images.json"]];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	//set data to string with encoding
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    SBJSON *jsonReader = [SBJSON new];
    jsonData = [jsonReader objectWithString:json_string error:nil];

    imagesArray = [NSMutableArray array];
    tagsArray = [NSMutableArray array];
    
    for (int i = 0; i< [[[jsonData valueForKey:@"categories"] valueForKey:@"id"]count];i++) {

        NSString *catIdFormJson = [NSString stringWithFormat:@"%@",[[[jsonData valueForKey:@"categories"] valueForKey:@"id"] objectAtIndex:i]];
        NSString *catuniqueFormJson = [NSString stringWithFormat:@"%@",[[[jsonData valueForKey:@"images"] valueForKey:@"catunique"] objectAtIndex:i]];
        
        if ([categoryId isEqualToString:catIdFormJson]) {

            folder = [[[jsonData valueForKey:@"categories"] valueForKey:@"catfold"] objectAtIndex:i];
        }
        if ([categoryId isEqualToString:catuniqueFormJson]) {

            [imagesArray addObject:[[jsonData valueForKey:@"images"] valueForKey:@"imgbname"]];
            [tagsArray addObject:[[jsonData valueForKey:@"images"] valueForKey:@"imgtag"]];
        }
    }
    //int x = arc4random()%[imagesArray count]-1;
    NSString *imageUrl = [NSString stringWithFormat:@"http://thepaperwall.com/%@%@",folder,[imagesArray objectAtIndex:1]];
    NSString *imageTag = [NSString stringWithFormat:@"%@",[tagsArray objectAtIndex:1]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    self.title = imageTag;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, 320, 426)];
    [self.view addSubview:imageView];
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

@end
