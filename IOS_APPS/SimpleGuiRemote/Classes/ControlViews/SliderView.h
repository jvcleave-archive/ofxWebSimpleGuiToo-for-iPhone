//
//  SliderIntView.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/24/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlValueObject.h"

@interface SliderView : UIView {
	UILabel	*nameLabel;
	UILabel	*minLabel;
	UILabel	*maxLabel;
	UILabel	*valueLabel;
	UISlider *slider;
	ControlValueObject *controlData;
	NSMutableDictionary *data;
	BOOL isFloat;
	NSString *delayedUpdateValue;
	double start;
	NSTimer *delayedTimer;

}
@property(nonatomic, retain) UISlider *slider;
@property(nonatomic, retain) UILabel	*nameLabel;
@property(nonatomic, retain) UILabel	*minLabel;
@property(nonatomic, retain) UILabel	*maxLabel;
@property(nonatomic, retain) UILabel	*valueLabel;
@property(nonatomic, retain) ControlValueObject	*controlData;
@property(nonatomic, retain) NSMutableDictionary	*data;
@property (nonatomic, copy) NSString *delayedUpdateValue;
@property (nonatomic, retain) NSTimer *delayedTimer;

- (id)initWithFrame:(CGRect)frame withData:(ControlValueObject *)incomingControlData isFloat:(BOOL)floatOption;
-(void) sliderAction:(id) sender;
-(UIColor *)randomColor;
-(void) sendDelayedValue:(NSTimer*)theTimer;
@end
