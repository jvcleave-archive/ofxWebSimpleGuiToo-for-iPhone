    //
//  TuioViewController.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 1/17/11.
//  Copyright 2011 jasonvancleave.com. All rights reserved.
//

#import "TuioViewController.h"
#import "Shape.h"

@implementation TuioViewController
@synthesize tuioSender, host, updateTimer;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];

	shapes = [[NSMutableArray alloc] init];
	
	self.title = @"TUIO";
	
	self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)] autorelease];
	self.view.multipleTouchEnabled = YES;
	self.view.backgroundColor = [UIColor redColor];
	activeTouches = [[NSMutableDictionary alloc] init];
	tuioSender = new MSATuioSenderCPP();
	tuioSender->verbose = true;
	tuioSender->setup([host UTF8String], [@"3333" intValue], 0, [host UTF8String]);
	tuioSender->tuioServer->enablePeriodicMessages();
	tuioSender->tuioServer->enableFullUpdate();
	updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.03
									 target:self
								   selector:@selector(onUpdateTimer:)
								   userInfo:nil
									repeats:YES];
}
- (void)onUpdateTimer
{
	//NSLog(@"onUpdateTimer");
}
- (void)onUpdateTimer:(NSTimer*)theTimer
{
	//NSLog(@"onUpdateTimer::theTimer");
	tuioSender->update();
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/******************* TOUCH EVENTS ********************/
//------------------------------------------------------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	int touchIndex =0;
	
	for(UITouch *touch in touches) {
		
		while([[activeTouches allValues] containsObject:[NSNumber numberWithInt:touchIndex]]) {
			touchIndex++;
		}
		
		[activeTouches setObject:[NSNumber numberWithInt:touchIndex] forKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView:self.view];
		Shape *shape = [[[Shape alloc] initWithFrame:CGRectMake(touchPoint.x, touchPoint.y, 60.0, 60.0)] autorelease];
		
		[self.view addSubview:shape];
		[shapes addObject:shape];

		
		float x = touchPoint.x/self.view.frame.size.width;
		float y = touchPoint.y/self.view.frame.size.height;
		tuioSender->cursorPressed(x, y, touchIndex);
		
	}
	printf("	TuioViewController::touchesBegan touchIndex: %d \n", touchIndex);
	
}


//------------------------------------------------------
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	//	NSLog(@"touchesMoved: %i %i %i", [touches count],  [[event touchesForView:self] count], multitouchData.numTouches);
	
	for(UITouch *touch in touches) {
		int touchIndex = [[activeTouches objectForKey:[NSValue valueWithPointer:touch]] intValue];
		[activeTouches setObject:[NSNumber numberWithInt:touchIndex] forKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView:self.view];
		
		Shape *shape = [[[Shape alloc] initWithFrame:CGRectMake(touchPoint.x, touchPoint.y, 60.0, 60.0)] autorelease];
		
		[self.view addSubview:shape];
		
		float x = touchPoint.x/self.view.frame.size.width;
		float y = touchPoint.y/self.view.frame.size.height;
		tuioSender->cursorDragged(x, y, touchIndex);
	}
	
}

//------------------------------------------------------
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//	NSLog(@"touchesEnded: %i %i %i", [touches count],  [[event touchesForView:self] count], multitouchData.numTouches);
	
	for(UITouch *touch in touches) {
		int touchIndex = [[activeTouches objectForKey:[NSValue valueWithPointer:touch]] intValue];
		
		[activeTouches removeObjectForKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView:self.view];

		float x = touchPoint.x/self.view.frame.size.width;
		float y = touchPoint.y/self.view.frame.size.height;
		tuioSender->cursorReleased(x, y, touchIndex);
	}
	for (UIView *shape in self.view.subviews) {
		[shape removeFromSuperview];
	}
}

//------------------------------------------------------
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesEnded:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	[updateTimer invalidate];
	[updateTimer release];
	tuioSender->close();
    [super dealloc];
}


@end
