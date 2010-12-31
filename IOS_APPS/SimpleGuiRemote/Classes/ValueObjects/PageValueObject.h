//
//  PageValueObject.h
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface PageValueObject : NSObject {
	NSString *name;
	NSArray *controlData;
	NSMutableArray *controls;
	NSMutableDictionary *data;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSArray *controlData;
@property (nonatomic, retain) NSMutableArray *controls;
@property (nonatomic, retain) NSMutableDictionary *data;

- (PageValueObject *) initWithJSONData:(NSMutableDictionary *)jsonData;
@end
