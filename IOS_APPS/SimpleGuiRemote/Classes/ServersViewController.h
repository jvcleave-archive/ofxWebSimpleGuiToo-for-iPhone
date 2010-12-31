//
//  ServersViewController.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServersViewController : UITableViewController {
	NSMutableArray *serversArray;
}
@property (nonatomic, retain) NSMutableArray *serversArray;
-(void) add:(id) sender;

@end
