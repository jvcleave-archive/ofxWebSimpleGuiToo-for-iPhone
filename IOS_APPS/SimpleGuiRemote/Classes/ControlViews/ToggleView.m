//
//  ToggleView.m
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/25/10.
//  Copyright 2010 . All rights reserved.
//

#import "ToggleView.h"


@implementation ToggleView
@synthesize toggle, label, controlData;

- (id)initWithFrame:(CGRect)frame withData:(ControlValueObject *)data
{
    
    self = [super initWithFrame:frame];
    if (self)
	{
		self.controlData = data;
		toggle = [[UISwitch alloc] initWithFrame: CGRectMake(186.0, 0.0, 94.0, 27.0)];
		[toggle setOn:[controlData toggleValue]];
		[toggle 
			addTarget: self
			action: @selector(flip:)
			forControlEvents: UIControlEventValueChanged];
		[self addSubview: toggle];
		label = [ [UILabel alloc ] initWithFrame:CGRectMake(0.0, 2.0, 150.0, 22.00) ];
		label.textAlignment =  UITextAlignmentLeft;
		label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
		label.text = [controlData name];
		[self addSubview:label];
		
		
    }
    return self;
}


- (void)dealloc {
	[toggle release];
	[label release];
	[controlData release];
    [super dealloc];
}
- (void) flip: (id) sender 
{
    NSLog(@"%@", toggle.on ? @"On" : @"Off");
	controlData.toggleValue = toggle.on;
	[controlData sendToggleValue];

	 
}

@end
