//
//  OFAppDataModel.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/27/10.
//  Copyright 2010 . All rights reserved.
//

#import "OFAppDataModel.h"
#import "ControlValueObject.h"
#import "PageValueObject.h"
#import "JSON.h"
@implementation OFAppDataModel
@synthesize serverURL, serverPort, responseData, pagesArray, connectionError, connectionURL;


-(id) init
{
	[super init];
	if (self) {
		responseData = [[NSMutableData alloc] init];
		pagesArray = [NSMutableArray array];
		connectionError = nil;
		[[NSNotificationCenter defaultCenter] 
			addObserver:self
			selector:@selector(onSendSliderDataNotification:)
			name:onControlValueObjectChange //imported from ControlValueObject
			object:nil
		 ];
	}
	return self;
}
-(void) connectToServer:(NSString *)server port:(NSString *) port
{
	self.serverURL = server;
	self.serverPort = port;
    connectionURL = [NSString stringWithFormat:@"http://%@:%@/control", server, port];
    NSURL *url = [NSURL URLWithString:connectionURL];
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&connectionError];
    // = [[NSArray alloc] init]; 
	
    NSArray *jsonValues = [jsonString JSONValue];
    //NSLog(@"Array description: %@ items.\n", jsonValues);
    [jsonString release];
    for (NSMutableDictionary *jsonValue in jsonValues) 
    {
        PageValueObject *pageData = [[PageValueObject alloc] initWithJSONData:jsonValue];
        if ([[pageData controls] count] > 0)
        {
            [pagesArray addObject:pageData];
			
        }
		[pageData release];
        //[jsonValue release];
    }
	NSLog(@"jsonValues ref %i", [jsonValues retainCount]);
	//[jsonValues release];
}
- (void)onSendSliderDataNotification:(NSNotification *)note
{
	//NSLog(@"onSendSliderDataNotification");
	//NSLog(@"%@ == %@", [[note userInfo] objectForKey:@"nameKey"], [[note userInfo] objectForKey:@"valueKey"]);
	
	NSString *urlString = [NSString stringWithFormat:@"http://%@:%@/control?key=%@&value=%@", 
						   self.serverURL,
						   self.serverPort,
						   [[note userInfo] objectForKey:@"nameKey"], 
						   [[note userInfo] objectForKey:@"valueKey"]
						   ];
	//NSLog(@"urlString: %@", urlString);
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
	//[requestObj release];
	
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData
{
    [responseData appendData:someData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Show error
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"connectionDidFinishLoading");
    // Once this method is invoked, "responseData" contains the complete result
	[connection release];
}

-(void) dealloc
{
	NSLog(@"OFAppDataModel dealloc");
	[serverURL release];
	[serverPort release];	
	[responseData release];	
	[connectionError release];
	[connectionURL release];
	[super dealloc];
}

@end
