//
//  RootViewController.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFAppDataModel.h"

@interface OFAppViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableArray *pagesArray;
	NSDictionary *data;
	OFAppDataModel *model;
	
}

@property (nonatomic, retain) NSMutableArray *pagesArray;
@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic, retain) OFAppDataModel *model;
-(void) onTUIOButtonTap:(id)sender;

@end
