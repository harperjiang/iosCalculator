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
  
    CGContextBeginPath(context);
    // Draw grids
    CGContextSetRGBStrokeColor(context, 0.7, 0.7, 0.7, 0.8);
    CGFloat pattern[] = {0.1,0.1};
    char* textBuffer = (char*)malloc(10);
    CGContextSetFontSize(context, 8);
    CGContextSetLineDash(context, 0, pattern, 2);
    for(int i = ceil(range.origin.x);i<range.origin.x+range.size.width;i++) {
        CGContextMoveToPoint(context, i, range.origin.y);
        CGContextAddLineToPoint(context, i, range.origin.y + range.size.height);
        CGContextSetTextPosition(context, i, range.origin.y + range.size.height-[self translate:10]);
        sprintf(textBuffer, "%d",i);
        CGContextShowText(context, textBuffer, strlen(textBuffer));
    }
    for(int i = ceil(range.origin.y);i<range.origin.y+range.size.height;i++) {
        CGContextMoveToPoint(context, range.origin.x, i);
        CGContextAddLineToPoint(context, range.origin.x+range.size.width, i);
        CGContextSetTextPosition(context, range.origin.x + range.size.width - [self translate:10], i);
        sprintf(textBuffer, "%d",i);
        CGContextShowText(context, textBuffer, strlen(textBuffer));
    }
    free(textBuffer);
    CGContextStrokePath(context);
}

@end
