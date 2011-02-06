//
//  TuioViewController.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 1/17/11.
//  Copyright 2011 jasonvancleave.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSATuioSenderCPP.h"


@interface TuioViewController : UIViewController {

	MSATuioSenderCPP			*tuioSender;
	NSTimer *updateTimer;
	int touchCounter;
	NSString *host;
	NSMutableDictionary		*activeTouches;
	NSMutableArray *shapes;
}

@property (readonly, nonatomic)	MSATuioSenderCPP *tuioSender;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, copy) NSString *host;
- (void)onUpdateTimer;
- (void)onUpdateTimer:(NSTimer*)theTimer;

@end
