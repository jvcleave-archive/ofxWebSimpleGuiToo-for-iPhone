//
//  ServerConfigValueObject.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerConfigValueObject : NSObject {

}
+(NSString *)NAME_KEY;
+(NSString *)SERVER_KEY;
+(NSString *)PORT_KEY;
+(NSString *)INDEX_KEY;
@end


extern NSString *const onServerAdd;
extern NSString *const onServerDelete;