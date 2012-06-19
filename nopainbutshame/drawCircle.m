//
//  View.m
//  testCircle
//
//  Created by Robert Frank on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "drawCircle.h"

@implementation drawCircle
@synthesize canDraw;

- (void)drawRect:(CGRect)rect {
    if (canDraw == YES) {
        NSLog(@"asdsada");
        // The color is by this line CGContextSetRGBFillColor( context , red , green , blue , alpha);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef, CGRectMake(100, 100, 25, 25));
        CGContextSetRGBFillColor(contextRef, 0, 0, 255, 1.0);
        
        // Draw a circle (border only)
        CGContextStrokeEllipseInRect(contextRef, CGRectMake(100, 200, 25, 25));
        CGContextSetRGBFillColor(contextRef, 0, 0, 255, 1.0); 
    }
}

@end
