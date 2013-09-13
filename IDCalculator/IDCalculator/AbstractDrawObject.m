//
//  DrawObject.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/16/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DrawObject.h"

@implementation DrawObject

-(id)init {
    self = [super init];
    if(self) {
        self.lineWidth = 1.0f;
    }
    return self;
}

-(void)draw:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, self.fillColor);
    CGContextSetStrokeColorWithColor(context, self.lineColor);
    CGContextSetLineWidth(context, self.lineWidth);
    [self paint:context];
    CGContextRestoreGState(context);
}

-(void)paint:(CGContextRef)context {
    // Do nothing
}

@end
