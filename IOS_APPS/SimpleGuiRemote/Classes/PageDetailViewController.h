//
//  PageDetailViewController.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageValueObject.h"

@interface PageDetailViewController : UIViewController {
	PageValueObject *pageData;
	UIScrollView *contentView;
	NSString *host;
}
@property (nonatomic, retain) PageValueObject *pageData;
@property (nonatomic, retain) UIScrollView *contentView;
-(void) onTUIOButtonTap:(id)sender;
@property (nonatomic, copy) NSString *host;

@end
