
#import <Foundation/Foundation.h>
#import "ControlValueObject.h"

@interface DataModel : NSObject {

	
	NSMutableArray *savedServers;
	NSString *path;

}


@property (nonatomic, retain) NSMutableArray *savedServers;
@property (nonatomic, copy) NSString *path;
-(void) createServer:(NSDictionary *)newEntry;
@end

