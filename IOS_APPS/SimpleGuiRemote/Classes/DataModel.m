//
//  DataModel.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 . All rights reserved.
//

#import "DataModel.h"
#import "ServerConfigValueObject.h"

@implementation DataModel
@synthesize savedServers, path;

-(id) init
{
	[super init];
	if (self) {
		
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        self.path = [documentsDirectory stringByAppendingPathComponent:@"servers.plist"];
        NSLog(@"init path %@", path);
		savedServers = [NSMutableArray arrayWithContentsOfFile:self.path];
		if(savedServers==nil )
		{
			NSLog(@"no servers");
			savedServers= [[NSMutableArray alloc] init];
			[savedServers writeToFile:path atomically:YES];
			savedServers = [NSMutableArray arrayWithContentsOfFile:self.path];
		}else {
			NSLog(@"found servers", savedServers);
		}
		[[NSNotificationCenter defaultCenter] 
						addObserver:self
						selector:@selector(onServerAddNotification:)
						name:onServerAdd
						object:nil
		 ];
		[[NSNotificationCenter defaultCenter] 
						addObserver:self
						selector:@selector(onServerDeleteNotification:)
						name:onServerDelete
						object:nil
						];
		
	}
	return self;

}
-(void) createServer:(NSDictionary *)newEntry
{
	NSMutableDictionary *editedEntry = [[NSMutableDictionary alloc] init];

	NSString *indexValue = [newEntry objectForKey:[ServerConfigValueObject INDEX_KEY]];
	
	if (! ([indexValue isEqual:@"666"]) && ([savedServers count] > 0) )
	{
		NSLog(@"new entry already exists, shouldn't overwrite %@", [newEntry objectForKey:[ServerConfigValueObject INDEX_KEY]]);
		for (int i=0; i<[savedServers count]; i++) 
		{
			
			NSDictionary *currentEntry = [savedServers objectAtIndex:i];
			NSString *currentIndex = [currentEntry objectForKey:[ServerConfigValueObject INDEX_KEY]];
			
			if ([currentIndex isEqualToString:[newEntry objectForKey:[ServerConfigValueObject INDEX_KEY]]]) 
			{
				//[savedServers removeObjectAtIndex:i];
				[savedServers replaceObjectAtIndex:i withObject:newEntry];
			}
		}
	}else {
		[editedEntry addEntriesFromDictionary:newEntry];
		NSString *index = [NSString stringWithFormat:@"%i", [savedServers count] + 1];
		[editedEntry setObject:index forKey:[ServerConfigValueObject INDEX_KEY]];
		[savedServers addObject:editedEntry];
	}

	
	
	[editedEntry release];
	[newEntry release];
    [savedServers writeToFile:self.path atomically:YES];
}

-(void) onServerDeleteNotification:(NSNotification *)note
{
	NSLog(@"onServerDeleteNotification %@ %@ %@ %@", 
		  [[note userInfo] objectForKey:[ServerConfigValueObject INDEX_KEY]], 
		  [[note userInfo] objectForKey:[ServerConfigValueObject NAME_KEY]],
		  [[note userInfo] objectForKey:[ServerConfigValueObject SERVER_KEY]], 
		  [[note userInfo] objectForKey:[ServerConfigValueObject PORT_KEY]]); 
	NSString *sentIndex = [[note userInfo] objectForKey:[ServerConfigValueObject INDEX_KEY]];
	for (int i=0; i<[savedServers count]; i++) 
	{
		
		NSDictionary *currentEntry = [savedServers objectAtIndex:i];
		NSString *currentIndex = [currentEntry objectForKey:[ServerConfigValueObject INDEX_KEY]];
		
		if ([currentIndex isEqualToString:sentIndex]) 
		{
			[savedServers removeObjectAtIndex:i];
		}
	}
	[savedServers writeToFile:self.path atomically:YES];
}
 -(void) onServerAddNotification:(NSNotification *)note
{
	NSLog(@"onServerAddNotification %@ %@, %@", [[note userInfo] objectForKey:[ServerConfigValueObject NAME_KEY]],[[note userInfo] objectForKey:[ServerConfigValueObject SERVER_KEY]], [[note userInfo] objectForKey:[ServerConfigValueObject PORT_KEY]]); 
    [self createServer:[note userInfo]];
	
}

-(void) dealloc
{
	//[savedServers release];
	//[path release];
	[super dealloc]; 
}
@end