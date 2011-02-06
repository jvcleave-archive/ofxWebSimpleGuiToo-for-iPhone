    //
//  PageDetailViewController.m
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import "PageDetailViewController.h"
#import "ControlValueObject.h"
#import "SliderView.h"
#import "ToggleView.h"
#import "ComboBoxView.h"
#import "TuioViewController.h"
#import "ServerConfigValueObject.h"

@implementation PageDetailViewController

@synthesize pageData, contentView, host;

int toggleCount = 0;

- (void)loadView
{
	[super loadView];
	
	contentView = [[UIScrollView alloc] init];
	contentView.frame = [[UIScreen mainScreen] applicationFrame];
	
	
	[contentView setScrollEnabled:YES];
	//
	
	NSLog(@"PageDetailViewController loadView");
	NSLog(@" PageDetailViewController loadView  control count %i", [[pageData controls] count]);
	
	float startX =20;
	float startY =0;
	float horizontialSpacing = 8;
	for (int i=0; i<[[pageData controls] count]; i++) {
		ControlValueObject *controlData = [[pageData controls] objectAtIndex:i];
		NSLog(@"controlType: %@", controlData.type);
		
		if ([[controlData type] isEqualToString:@"Toggle"])
		{
			
			
			ToggleView *toggle = [[ToggleView alloc] initWithFrame: CGRectMake(startX, startY, 280, 27.0) withData:controlData];
			[contentView addSubview: toggle];
			startY+=(toggle.frame.size.height + horizontialSpacing);
			[toggle release];
		}
		
		if ([[controlData type] isEqualToString:@"SliderInt"] || [[controlData type] isEqualToString:@"SliderFloat"])
		{
			BOOL isFloat = [[controlData type] isEqualToString:@"SliderFloat"];
			//NSLog(@"build SliderInt %@ %@ %@", [controlData.data objectForKey:@"min"], [controlData.data objectForKey:@"max"], [controlData.data objectForKey:@"value"]);
			
			SliderView *sliderView = [[SliderView alloc] initWithFrame:CGRectMake(startX, startY, 280, 75.0) withData:controlData isFloat:isFloat] ;
			[contentView addSubview:sliderView];
			
			startY+=(sliderView.frame.size.height + horizontialSpacing);
			
			[sliderView release];
		}
		if ([[controlData type] isEqualToString:@"ComboBox"])
		{
			
			
			ComboBoxView *pickerView = [[ComboBoxView alloc] initWithFrame: CGRectMake(0, startY, 320, 216) withData:controlData];
			[contentView addSubview: pickerView];
			startY+=(pickerView.frame.size.height + horizontialSpacing);
			[pickerView release];
		}
	}
	contentView.contentSize = CGSizeMake(100, startY+100);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"TUIO" style:UIBarButtonItemStyleBordered target:self action:@selector(onTUIOButtonTap:)];
	[self.view addSubview:contentView];
}

-(void) onTUIOButtonTap:(id)sender
{
	NSLog(@"onTUIOButtonTap");
	TuioViewController *tuioViewController = [[TuioViewController alloc] init];
	tuioViewController.host = host;
	[self.navigationController pushViewController:tuioViewController animated:YES];
	[tuioViewController release];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
	[contentView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
	NSLog(@"may crash here PageDetailViewController pagedata release");
	//[pageData release];

    [super dealloc];
}


@end
