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
    CGRect range = [[self environment] range];
    
    CGContextBeginPath(context);
    
    if(range.origin.x < 0 && range.origin.x + range.size.width > 0) {
        // Draw Y label
        CGContextSetTextPosition(context, [self translate:5], range.origin.y+range.size.height-[self translate:15]);
        CGContextShowText(context, "Y", 1);
        
        // Draw Y axis line
        CGContextMoveToPoint(context, 0, range.origin.y);
        CGContextAddLineToPoint(context, 0, range.origin.y + range.size.height);

    }
    
    if(range.origin.y < 0 && range.origin.y + range.size.height > 0) {
        // Draw X label
        CGContextSetTextPosition(context, range.origin.x+range.size.width-[self translate:15], [self translate:5]);
        CGContextShowText(context, "X", 1);
        
        // Draw X axis line
        CGContextMoveToPoint(context, range.origin.x, 0);
        CGContextAddLineToPoint(context, range.origin.x + range.size.width, 0);
    }
  
    CGContextStrokePath(context);
}

@end
