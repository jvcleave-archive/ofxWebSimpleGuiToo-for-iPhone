//
//  ComboBoxView.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/25/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlValueObject.h"

@interface ComboBoxView : UIView <UIPickerViewDelegate, UIPickerViewDataSource> {
	UILabel *label;
	UIPickerView *uiPickerView;
	ControlValueObject *controlData;
	NSMutableDictionary *data;
	NSMutableArray *nameOptions;

}
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIPickerView *uiPickerView;
@property(nonatomic, retain) ControlValueObject	*controlData;
@property(nonatomic, retain) NSMutableDictionary	*data;
@property (nonatomic, retain) NSMutableArray *nameOptions;

- (id)initWithFrame:(CGRect)frame withData:(ControlValueObject *)data;
@end
