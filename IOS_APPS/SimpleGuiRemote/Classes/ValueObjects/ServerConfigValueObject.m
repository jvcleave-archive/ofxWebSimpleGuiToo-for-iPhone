//
//  ServerConfigValueObject.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigValueObject.h"


@implementation ServerConfigValueObject

NSString *const onServerAdd = @"onServerAdd";
NSString *const onServerDelete = @"onServerDelete";
static NSString * const  ServerConfigValueObject_NAME_KEY= @"NAME";
static NSString * const  ServerConfigValueObject_SERVER_KEY= @"ADDRESS";
static NSString * const ServerConfigValueObject_PORT_KEY = @"PORT";
static NSString * const ServerConfigValueObject_INDEX_KEY = @"INDEX";

+(NSString *)SERVER_KEY
{
	return ServerConfigValueObject_SERVER_KEY;
}
+(NSString *)PORT_KEY
{
	return ServerConfigValueObject_PORT_KEY;
}
+(NSString *)NAME_KEY
{
	return ServerConfigValueObject_NAME_KEY;
}
+(NSString *)INDEX_KEY
{
	return ServerConfigValueObject_INDEX_KEY;
}


@end
