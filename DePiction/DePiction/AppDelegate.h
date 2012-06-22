//
//  AppDelegate.h
//  DePiction
//
//  Created by Spire Jankulovski on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "DataSet.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>
{
    Facebook *facebook;
    DataSet *apiData;
    NSMutableDictionary *userPermissions;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain) Facebook *facebook;

@property (nonatomic, retain) DataSet *apiData;

@property (nonatomic, retain) NSMutableDictionary *userPermissions;

@end
