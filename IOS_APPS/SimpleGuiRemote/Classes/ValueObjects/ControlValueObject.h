//
//  ControlValueObject.h
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlValueObject : NSObject {
	NSMutableDictionary * data;
	NSMutableDictionary *choices;
	NSString *name;
	NSString *type;
	NSString *value;
	BOOL toggleValue;
	
	
}

@property (nonatomic, retain) NSMutableDictionary * data;
@property (nonatomic, retain) NSMutableDictionary * choices;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;
@property BOOL toggleValue;

- (ControlValueObject *) initWithControlData:(NSMutableDictionary *)controlData;
-(void) sendToggleValue;
-(void) sendSliderData:(BOOL)isFloat;
-(void) sendComboBoxData;
-(void)broadcastChange: (NSString *)nameValue withValue:(NSString *)keyValue;

@end


extern NSString *const onControlValueObjectChange;