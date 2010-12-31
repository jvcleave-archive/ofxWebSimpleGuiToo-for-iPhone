//
//  ControlValueObject.m
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import "ControlValueObject.h"


@implementation ControlValueObject
@synthesize name, data, type, value, toggleValue, choices;

NSString *const onControlValueObjectChange = @"onControlValueObjectChange";

static NSString * const nameKey = @"nameKey";
static NSString * const valueKey = @"valueKey";

- (ControlValueObject *) initWithControlData:(NSMutableDictionary *)controlData
{
	self = [super init];
	if(self)
	{
		self.data = controlData;
		self.name = [[NSString alloc] initWithString:[self.data objectForKey:@"name"]];
		self.type= [[NSString alloc] initWithString:[self.data objectForKey:@"type"]];
		
		if ([self.data objectForKey:@"value"]) 
		{
			//self.value= [[NSString alloc] initWithString:[self.data objectForKey:@"value"]];
			self.value= [self.data objectForKey:@"value"];

			if ([self.type isEqualToString:@"Toggle"] ) 
			{
				if ([self.value isEqualToString:@"false"] ) 
				{
					toggleValue = NO;
				}
				if ([self.value isEqualToString:@"true"] ) 
				{
					toggleValue = YES;
				}
			}
		}
		
		if ([self.data objectForKey:@"choices"]) {
			choices = [self.data objectForKey:@"choices"];
			//NSLog(@"choices %i", [choices count]);
		}
		/**/
		//NSLog(@"ControlValueObject %@ %@", self.name, self.type);
	}
	return self;
}
-(void) sendToggleValue
{
	NSString *stringValue;
	if (toggleValue) {
		stringValue =@"true";
	}else {
		stringValue =@"false";
	}
	[self broadcastChange:name withValue:stringValue];
	[stringValue release];

}
-(void) sendSliderData:(BOOL) isFloat
{
	[self broadcastChange:name withValue:[self.data objectForKey:@"value"]];
	
}
-(void) sendComboBoxData
{
	
	[self broadcastChange:name withValue:value];
}

-(void)broadcastChange:(NSString *)nameValue withValue:(NSString *)keyValue
{
	[[NSNotificationCenter defaultCenter] 
						postNotificationName:onControlValueObjectChange 
						object:self
						userInfo: [NSDictionary dictionaryWithObjectsAndKeys: 
								   nameValue, 
								   nameKey, 
								   keyValue, 
								   valueKey, 
								   nil]
	 ];									   
}
-(void) dealloc
{
	
	[name release];
	[type release];
	[value release];
	[data release];
	for (ControlValueObject *c in choices)
	{
		[c release];
	}
	[choices release];
	NSLog(@"ControlValueObject dealloc");
	[super dealloc];
	
}

@end