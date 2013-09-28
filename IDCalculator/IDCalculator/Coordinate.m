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
    CGFloat linewidth = [self translate:2];
    CGFloat pattern[] = {linewidth,linewidth};
    char* textBuffer = (char*)malloc(10);
    CGContextSetFontSize(context, 8);
    CGContextSetLineDash(context, 0, pattern, 2);
    CGFloat unit = [self translate:20];
    
    CGAffineTransform transform = CGContextGetTextMatrix(context);
    CGAffineTransform rotated = CGAffineTransformRotate(transform, -M_PI/2);
    CGContextSetTextMatrix(context, rotated);
    // Draw vertical line
    for(CGFloat start = ceil(range.origin.x/unit)*unit;start<range.origin.x+range.size.width;start+=unit) {
        CGContextMoveToPoint(context, start, range.origin.y);
        CGContextAddLineToPoint(context, start, range.origin.y + range.size.height);
        CGContextSetTextPosition(context, start, range.origin.y + range.size.height-[self translate:5]);
        sprintf(textBuffer, "%.2f",start);
        CGContextShowText(context, textBuffer, strlen(textBuffer));
    }
    CGContextSetTextMatrix(context, transform);
    // Draw horizontal line
    for(CGFloat start = ceil(range.origin.y/unit)*unit;start<range.origin.y+range.size.height;start+=unit) {
        CGContextMoveToPoint(context, range.origin.x, start);
        CGContextAddLineToPoint(context, range.origin.x+range.size.width, start);
        CGContextSetTextPosition(context, range.origin.x + range.size.width - [self translate:20], start);
        sprintf(textBuffer, "%.2f",start);
        CGContextShowText(context, textBuffer, strlen(textBuffer));
    }
    free(textBuffer);
    CGContextStrokePath(context);
}

@end
