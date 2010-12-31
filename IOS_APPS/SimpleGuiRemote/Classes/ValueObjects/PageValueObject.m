//
//  PageValueObject.m
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import "PageValueObject.h"
#import "ControlValueObject.h"

@implementation PageValueObject

@synthesize name, controlData, controls, data;

- (PageValueObject *) initWithJSONData:(NSMutableDictionary *)jsonData
{
	self = [super init];
	if(self)
	{
		self.data = jsonData;
		self.name = [self.data objectForKey:@"name"];
		self.controlData= [self.data objectForKey:@"controls"];
		
		
		if ([self.controlData count]>0) {
			self.controls = [[NSMutableArray alloc] init];
			for (NSMutableDictionary *control in self.controlData)
			{
				if ([control objectForKey:@"type"] != nil) 
				{
					ControlValueObject *controlValueObject = [[ControlValueObject alloc] initWithControlData:control];
					[self.controls addObject:controlValueObject];
					[controlValueObject release];
				}
			}
		}
		

	}
	return self;
}
-(void) dealloc
{
	NSLog(@"PageValueObject dealloc controls count: %i", [controls count]);

	[data release];
	[name release];
	for (ControlValueObject *controlValueObject in controls) {
		//[controlValueObject release];
		NSLog(@"PageValueObject dealloc getting controlValueObject retainCount: %i type:%@", [controlValueObject retainCount]);
		if ([controlValueObject retainCount]>1 ) {
			[controlValueObject release];
		}
		
	}
	[controlData release];
	[controls release];
	NSLog(@"PageValueObject dealloc");
	[super dealloc];
}
@end
