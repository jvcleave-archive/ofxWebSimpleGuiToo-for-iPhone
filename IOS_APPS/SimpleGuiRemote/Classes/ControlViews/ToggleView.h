//
//  ToggleView.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/25/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlValueObject.h"

@interface ToggleView : UIView {
	UISwitch *toggle;
	UILabel *label;
	ControlValueObject *controlData;
}
@property(nonatomic, retain) UISwitch	*toggle;
@property(nonatomic, retain) UILabel	*label;
@property(nonatomic, retain) ControlValueObject *controlData;
- (id)initWithFrame:(CGRect)frame withData:(ControlValueObject *)data;
- (void) flip: (id) sender;
@end
