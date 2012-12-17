//
//  Coordinate.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

-(void)paint:(CGContextRef)context {
    CGContextBeginPath(context);
    CGRect rect = CGContextGetClipBoundingBox(context);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2);
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width / 2, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
    CGContextStrokePath(context);
}

@end
