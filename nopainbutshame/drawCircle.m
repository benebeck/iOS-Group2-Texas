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
@synthesize activeplayer;

- (void)drawRect:(CGRect)rect {
    if (canDraw == YES) {
        
        
        NSLog(@"asdsada");
        // The color is by this line CGContextSetRGBFillColor( context , red , green , blue , alpha);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef, CGRectMake(5, 40, 25, 25));
        
        if(activeplayer==1)CGContextSetRGBFillColor(contextRef, 0, 0, 255, 1.0);
        else {
            CGContextSetRGBFillColor(contextRef, 255, 0, 255, 1.0);
        }
        CGContextRef contextRef2 = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef2, CGRectMake(100, 5, 25, 25));
        if(activeplayer==2)CGContextSetRGBFillColor(contextRef2, 0, 0, 255, 1.0);
        else {
            CGContextSetRGBFillColor(contextRef2, 255, 0, 255, 1.0);
        }
        CGContextRef contextRef3 = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef3, CGRectMake(165, 40, 25, 25));
        if(activeplayer==3)CGContextSetRGBFillColor(contextRef3, 0, 0, 255, 1.0);
        else {
            CGContextSetRGBFillColor(contextRef3, 255, 0, 255, 1.0);
        }
        
        CGContextRef contextRef4 = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef4, CGRectMake(270, 5, 25, 25));
        if(activeplayer==4)CGContextSetRGBFillColor(contextRef4, 0, 0, 255, 1.0);
        else {
            CGContextSetRGBFillColor(contextRef4, 255, 0, 255, 1.0);
        }
        CGContextRef contextRef5 = UIGraphicsGetCurrentContext();
        // Draw a circle (filled)
        CGContextFillEllipseInRect(contextRef5, CGRectMake(320, 40, 25, 25));
        if(activeplayer==5)CGContextSetRGBFillColor(contextRef5, 0, 0, 255, 1.0);
        else {
            CGContextSetRGBFillColor(contextRef5, 255, 0, 255, 1.0);
        }
    }
}

@end
