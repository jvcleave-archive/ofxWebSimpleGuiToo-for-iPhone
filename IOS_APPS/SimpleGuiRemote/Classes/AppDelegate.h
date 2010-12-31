//
//  NativeAppNavBasedAppDelegate.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/20/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServersViewController.h"
#import "DataModel.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, UIActionSheetDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	ServersViewController *viewController;
	DataModel *dataModel;
	NSString *selectedPage;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) NSString *selectedPage;
@property (nonatomic, retain) DataModel *dataModel;
//

@property (nonatomic, retain) ServersViewController *viewController;
//-(void) connectToServer(id) sender;

@end