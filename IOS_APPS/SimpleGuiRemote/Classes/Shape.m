//
//  Shape.m
//  EllipticalAnimation
//
//  Created by James Eberhardt on 06/12/08.
//  Copyright 2008 Echo Mobile Inc. All rights reserved.
//

#import "Shape.h"


@implementation Shape


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	// Set the fill color for any drawing
	CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
	
	// Fill rect convenience equivalent to AddEllipseInRect(); FillPath();
	CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(0.0, 0.0, 60.0, 60.0));
}



- (void)dealloc {
    [super dealloc];
}


@end
