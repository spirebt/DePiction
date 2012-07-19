//
//  GameViewController.m
//  DePiction
//
//  Created by Spire Jankulovski on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "AppDelegate.h"
#import "SBJSON.h"
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
    // alphabetArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    alphabetArray = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];

    answerArray = [NSMutableArray array];  
    randomLetters = [NSMutableArray array];
    finalLetters = [NSMutableArray array];  
    guessArray = [NSMutableArray array];
    answerString = [NSString string]; 

    // Do any additional setup after loading the view from its nib.
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];   
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+1); 
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollview];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    imagesArray = [NSMutableArray array];
    tagsArray = [NSMutableArray array];
    
    for (int i = 0; i< [[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"id"]count];i++) {

        NSString *catIdFormJson = [NSString stringWithFormat:@"%@",[[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"id"] objectAtIndex:i]];

        if ([categoryId isEqualToString:catIdFormJson]) {

            folder = [[[delegate.imagesJsonData valueForKey:@"categories"] valueForKey:@"catfold"] objectAtIndex:i];
        }
    }
    for (int i = 0; i< [[[delegate.imagesJsonData valueForKey:@"images"] valueForKey:@"id"]count];i++) {
        NSString *catuniqueFormJson = [NSString stringWithFormat:@"%@",[[[delegate.imagesJsonData valueForKey:@"images"] valueForKey:@"catunique"] objectAtIndex:i]];

        if ([categoryId isEqualToString:catuniqueFormJson]) {
            [imagesArray addObject:[[[delegate.imagesJsonData valueForKey:@"images"] valueForKey:@"imgbname"] objectAtIndex:i]];
            [tagsArray addObject:[[[delegate.imagesJsonData valueForKey:@"images"] valueForKey:@"imgtag"] objectAtIndex:i]];
        }
    }

    int imgArray = [imagesArray count];
    int x = arc4random()%imgArray;
    
    NSString *imageUrl = [NSString stringWithFormat:@"http://thepaperwall.com/suimages/%@/%@",folder,[imagesArray objectAtIndex:x]];

   imageTag = [NSString stringWithFormat:@"%@",[tagsArray objectAtIndex:x]];

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    self.title = imageTag;
    //split answer into array of letters
    for (int i=0;i<[imageTag length];i++){
        NSString *str = [NSString stringWithFormat:@"%C",[imageTag characterAtIndex:i]];
        [answerArray addObject:str];
    }
   // NSLog(@"answerArray %@",answerArray);
    
    for (int i = 0; i< (16 - [answerArray count]); i++) {
        [randomLetters addObject:[self randomFromAlphabet]];
    }
    for (int i = 0; i< [answerArray count]; i++) {
        [randomLetters addObject:[answerArray objectAtIndex:i]];
    }    

   finalLetters = [self shuffle:randomLetters];
    //Get This it' Important
    //NSLog(@"%@",finalLetters);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, 320, 426)];
    [scrollview addSubview:imageView];
    
    UIButton *freezbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [freezbutton setBackgroundColor:[UIColor clearColor]];
    [freezbutton setFrame:CGRectMake(0, 0, 77, 77)];
    [freezbutton setImage:[UIImage imageNamed:@"freeze_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:freezbutton];
    
    UIImage *coinsImage = [UIImage imageNamed:@"coins_bg.png"];
    UIImageView *coinsImageView = [[UIImageView alloc]initWithImage:coinsImage];
    [coinsImageView setFrame:CGRectMake(172, 0, 148, 78)];
    [self.view addSubview:coinsImageView];
    
    UIButton *emptyAnswer = [UIButton buttonWithType:UIButtonTypeCustom];
    [emptyAnswer setBackgroundColor:[UIColor clearColor]];
    [emptyAnswer setFrame:CGRectMake(0, 0, 77, 77)];
    [emptyAnswer setImage:[UIImage imageNamed:@"freeze_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:emptyAnswer];

    
    /***************************Given Letters****************************/
    for (int i=0; i<8; i++) {
        
        /***************************Bottom Row***************************/
       
        
        UIButton *firstRowGiven = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstRowGiven setFrame:CGRectMake(0+(40*i), self.view.frame.size.height-72, 40, 35)];
        firstRowGiven.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;

        [firstRowGiven setBackgroundImage:[[UIImage imageNamed:@"givenLett_bg.png"]
                                stretchableImageWithLeftCapWidth:9 topCapHeight:9]
                      forState:UIControlStateNormal];
        
        [firstRowGiven setTitle:[finalLetters objectAtIndex:i] forState:UIControlStateNormal];
        [firstRowGiven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [firstRowGiven setTitleColor:[UIColor whiteColor] forState:UIControlEventTouchUpInside];

        [firstRowGiven addTarget:self action:@selector(getLetter:) forControlEvents:UIControlEventTouchUpInside];
        [firstRowGiven setTag:i];
        [self.view addSubview:firstRowGiven];
        
        /***************************Top Row***************************/
        
        UIButton *secondRowGiven = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondRowGiven setFrame:CGRectMake(0+(40*i), self.view.frame.size.height-107, 40, 35)];
        secondRowGiven.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        
        [secondRowGiven setBackgroundImage:[[UIImage imageNamed:@"givenLett_bg.png"]
                                           stretchableImageWithLeftCapWidth:9 topCapHeight:9]
                                 forState:UIControlStateNormal];
        
        [secondRowGiven setTitle:[finalLetters objectAtIndex:(i+8)] forState:UIControlStateNormal];
        [secondRowGiven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [secondRowGiven setTitleColor:[UIColor whiteColor] forState:UIControlEventTouchUpInside];
        
        [secondRowGiven addTarget:self action:@selector(getLetter:) forControlEvents:UIControlEventTouchUpInside];
        [secondRowGiven setTag:8+i];
        
        [self.view addSubview:secondRowGiven];

    }
    for (int i = 0; i < [imageTag length] ; i++) {
        answerButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [answerButton setFrame:CGRectMake(((320-([imageTag length]*35))/2)+(35*i), self.view.frame.size.height-143, 31, 35)];
        answerButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        
        [answerButton setBackgroundImage:[[UIImage imageNamed:@"guessedLett_bg.png"]
                                            stretchableImageWithLeftCapWidth:9 topCapHeight:9]
                                  forState:UIControlStateNormal];
        
        //[answerButton setTitle:[finalLetters objectAtIndex:(i+8)] forState:UIControlStateNormal];
        [answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [answerButton setTitleColor:[UIColor whiteColor] forState:UIControlEventTouchUpInside];
        
        [answerButton addTarget:self action:@selector(getLetter:) forControlEvents:UIControlEventTouchUpInside];
        [answerButton setTag:8+i];
        [self.view addSubview:answerButton];

    }
}
- (NSMutableArray *)shuffle:(NSMutableArray *)array
{
    
    static BOOL seeded = NO;
    if(!seeded)
    {
        seeded = YES;
        srandom(time(NULL));
    }
    
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return array;
}


-(void)getLetter:(id)sender{
    UIButton *button = (UIButton *)sender;
    //NSLog(@"%d",[button tag]);
    //[guessArray addObject:[finalLetters objectAtIndex:[button tag]]];
    answerString = [NSString stringWithFormat:@"%@%@",answerString,[finalLetters objectAtIndex:[button tag]]];

    if ([answerString isEqualToString:imageTag]) {
        NSLog(@"s - %@",answerString);
    }else{
        NSLog(@"W - %@",answerString);
    }
}
-(NSString *)randomFromAlphabet{
    id obj;    
    int r = arc4random() % [alphabetArray count];
    if(r<[alphabetArray count])
        obj=[alphabetArray objectAtIndex:r];
    else
    {
        NSLog(@"error");
    }
    return obj;

}
//appadmin/dbmanipulation/dbmanipulation.php?function=update
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
