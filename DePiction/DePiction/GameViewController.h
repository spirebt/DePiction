//
//  GameViewController.h
//  DePiction
//
//  Created by Spire Jankulovski on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
{
    NSString *categoryId;
    NSMutableArray *imagesArray;
    NSMutableArray *tagsArray;
    NSString *folder;
    UIScrollView *scrollview;
    NSArray *alphabetArray;
    NSMutableArray *answerArray;
    NSMutableArray *randomLetters;
    NSMutableArray *finalLetters;
    NSMutableArray *guessArray;
    NSString *answerString;
    NSString *imageTag;
    UIButton *answerButton;
}
@property(nonatomic, strong)NSString *categoryId;
@end
