//
//  VsComViewController.h
//  DePiction
//
//  Created by Spire Jankulovski on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VsComViewController : UITableViewController
{
    NSMutableArray *jsonData;
    NSMutableDictionary *categoryNames;
    int cellTag;
}
@end
