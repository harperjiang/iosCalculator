//
//  Coordinate.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

-(Coordinate*) init {
    self = [super init];
    if(self) {
        [self setFontSize:15];
    }
    return self;
}

-(void)paint:(CGContextRef)context {
    CGContextBeginPath(context);
    CGRect rect = CGContextGetClipBoundingBox(context);
    
    CGContextSetTextMatrix(context, CGAffineTransformMake(1, 0, 0, -1, 0, 0));
    // Draw Y axis
    CGContextSetTextPosition(context, rect.size.width/2+5, 20);
    CGContextShowText(context, "Y", 1);
    
    // Draw X axis
    CGContextSetTextPosition(context, rect.size.width - 15, rect.size.height/2-5);
    CGContextShowText(context, "X", 1);
    
    // Draw axis line
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2);
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width / 2, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
    
    CGContextStrokePath(context);
}

@end
