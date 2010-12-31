//
//  OFAppDataModel.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/27/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OFAppDataModel : NSObject {
	NSString *serverURL;
	NSString *serverPort;
	NSMutableData *responseData;
	NSMutableArray *pagesArray;
	NSError *connectionError;
	NSString *connectionURL;
}
@property (nonatomic, copy) NSString *serverURL;
@property (nonatomic, copy) NSString *serverPort;
@property (nonatomic, copy)  NSString *connectionURL;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSMutableArray *pagesArray;
@property (nonatomic, retain) NSError *connectionError; 
- (void)onSendSliderDataNotification:(NSNotification *)note;
-(void) connectToServer:(NSString *)server port:(NSString *) port;

@end
