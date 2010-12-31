//
//  SliderView.m
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/24/10.
//  Copyright 2010 . All rights reserved.
//

#import "SliderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SliderView

@synthesize slider, minLabel, maxLabel, valueLabel, nameLabel, controlData, data, delayedUpdateValue, delayedTimer;

- (id)initWithFrame:(CGRect)frame  withData:(ControlValueObject *) incomingControlData isFloat:(BOOL)floatOption{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.controlData = incomingControlData;
		self.data = controlData.data;
		isFloat = floatOption;
		CGRect nameFrame = CGRectMake(0.0, 0.0, 280.0, 29.0);
		nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
		nameLabel.textAlignment = UITextAlignmentLeft;
		[nameLabel setText:@"nameLabel:"];
		nameLabel.userInteractionEnabled = NO;
		
		slider = [[UISlider alloc] initWithFrame:CGRectMake(0.0, 31.0, 280, 22.0)];
		[slider  addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
		
		//slider.backgroundColor = [UIColor yellowColor];
		
		
		UIFont *valueFont = [UIFont fontWithName:@"Helvetica" size:12];
		CGRect labelFrame = CGRectMake(0.0, 61.0, 280, 20.0);
		minLabel = [[UILabel alloc] initWithFrame:labelFrame];
		minLabel.backgroundColor = [UIColor clearColor];
		minLabel.font = valueFont;
		minLabel.textAlignment = UITextAlignmentLeft;
		[minLabel setText:@"minLabel:"];
		minLabel.userInteractionEnabled = NO;
		
		maxLabel = [[UILabel alloc] initWithFrame:labelFrame];
		maxLabel.font = valueFont;
		maxLabel.textAlignment = UITextAlignmentRight;
		maxLabel.backgroundColor = [UIColor clearColor];
		[maxLabel setText:@"maxLabel:"];
		maxLabel.userInteractionEnabled = NO;
		
		valueLabel = [[UILabel alloc] initWithFrame:labelFrame];
		valueLabel.font = valueFont;
		valueLabel.textAlignment = UITextAlignmentCenter;
		valueLabel.backgroundColor = [UIColor clearColor];
		[valueLabel setText:@"valueLabel:"];
		valueLabel.userInteractionEnabled = NO;
		
		nameLabel.text =		[data objectForKey:@"name"];
		minLabel.text =			[data objectForKey:@"min"];
		maxLabel.text =			[data objectForKey:@"max"];
		valueLabel.text =		[data objectForKey:@"value"];
		if (!isFloat) {
			slider.minimumValue =	[[data objectForKey:@"min"]		intValue];
			slider.maximumValue =	[[data objectForKey:@"max"]		intValue];
			slider.value =			[[data objectForKey:@"value"]	intValue];
			
		}else{
			slider.minimumValue =	[[data objectForKey:@"min"]		floatValue];
			slider.maximumValue =	[[data objectForKey:@"max"]		floatValue];
			slider.value =			[[data objectForKey:@"value"]	floatValue];
			minLabel.text =			[NSString stringWithFormat:@"%.2f", (float)slider.minimumValue];
			maxLabel.text =			[NSString stringWithFormat:@"%.2f", (float)slider.maximumValue];
			valueLabel.text =		[NSString stringWithFormat:@"%.2f", (float)slider.value];
		}

		
		[self addSubview:maxLabel];
		[self addSubview:minLabel];
		[self addSubview:valueLabel];
		[self addSubview:slider];
		[self addSubview:nameLabel];
		start  = CACurrentMediaTime(); 
		
    }
    return self;
}
-(void) sliderAction:(id) sender
{

	if ([delayedTimer isValid] ) 
	{
		[delayedTimer invalidate];
		delayedTimer = nil;
	}

	NSString *updatedValue;
	if (isFloat) {
		 updatedValue= [NSString stringWithFormat:@"%f", (float)slider.value];
		valueLabel.text = [NSString stringWithFormat:@"%.2f", updatedValue];
	}else {
		updatedValue = [NSString stringWithFormat:@"%i", (int)slider.value];
		valueLabel.text = updatedValue;
	}

	
	
	double finish = CACurrentMediaTime(); 
	double duration = finish - start;
	[data setValue:updatedValue forKey:@"value"];
	if (duration>0.08) {
		start  = CACurrentMediaTime();
		[self.controlData sendSliderData:isFloat];
	}else {
		NSLog(@"duration is %f backing off ", duration);
		
		self.delayedUpdateValue = updatedValue;
		delayedTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(sendDelayedValue:) userInfo:nil repeats:NO];
	}

	
}

-(void) sendDelayedValue:(NSTimer*)theTimer
{
	NSLog(@"sent delayed value");
	delayedTimer = nil;
	[self.controlData sendSliderData:isFloat];
}
- (void)dealloc {
	[maxLabel release];
	[minLabel release];
	[valueLabel release];
	[slider release];
	[nameLabel release];
	[data release];
	[controlData release];
    [super dealloc];
}
-(UIColor *)randomColor
{
	CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
