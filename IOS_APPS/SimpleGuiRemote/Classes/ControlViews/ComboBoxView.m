//
//  ComboBoxView.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/25/10.
//  Copyright 2010 . All rights reserved.
//

#import "ComboBoxView.h"


@implementation ComboBoxView

@synthesize uiPickerView, controlData, data, nameOptions, label;
- (id)initWithFrame:(CGRect)frame withData:(ControlValueObject *)incomingControlData{
    
    self = [super initWithFrame:frame];
    if (self) {
		
		
		self.controlData = incomingControlData;
		self.data = controlData.data;
		
		
		label  = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 320, 40)];
		label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
		label.textAlignment = UITextAlignmentLeft;
		label.backgroundColor = [UIColor clearColor];
		[label setText:controlData.name];
		label.userInteractionEnabled = NO;
		
		
		uiPickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 50, 320, 216)];
		uiPickerView.showsSelectionIndicator = YES;
		uiPickerView.delegate = self;
		
		NSMutableArray *options = [NSMutableArray array];
		for(NSString *choice in controlData.choices)
		{
			[options addObject:choice];
		}
		self.nameOptions = [[NSArray alloc] initWithArray:options copyItems:YES];
		
		NSLog(@"row to select %@", self.controlData.value);
		[uiPickerView selectRow:[controlData.value intValue] inComponent:0 animated:NO]; 
								
		[self addSubview:label];
		[self addSubview:uiPickerView];
		
		
    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [nameOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	 NSLog(@"titleForRow optionForRow nameOptions%@", nameOptions);
    //return [optionForRow objectForKey:@"value"];
	return [NSString stringWithFormat:@"%@", [nameOptions objectAtIndex:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
     NSDictionary *optionForRow = [nameOptions objectAtIndex:row];
	controlData.value = [NSString stringWithFormat:@"%i", row];
	[controlData sendComboBoxData];
    NSLog(@"didSelectRow optionForRow %@", optionForRow);
}


- (void)dealloc {
	
	[uiPickerView release];
	[controlData release];
	[data release];
	[nameOptions release];
	[label release];
    [super dealloc];
}


@end
