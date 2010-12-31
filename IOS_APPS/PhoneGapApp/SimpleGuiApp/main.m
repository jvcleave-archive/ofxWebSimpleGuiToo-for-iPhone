//
//  main.m
//  SimpleGuiApp
//
//  Created by jason van cleave on 12/19/10.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"SimpleGuiAppAppDelegate");
    [pool release];
    return retVal;
}
