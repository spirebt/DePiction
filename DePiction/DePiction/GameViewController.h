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
    NSMutableArray *jsonData;
    NSMutableArray *imagesArray;
    NSMutableArray *tagsArray;
    NSString *folder;

}
@property(nonatomic, strong)NSString *categoryId;
@end
