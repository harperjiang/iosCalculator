//
//  DrawObject.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/16/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "AbstractDrawObject.h"

@implementation AbstractDrawObject

-(id)init {
    self = [super init];
    if(self) {
        self.lineWidth = 1.0f;
        self.fontSize = 10;
    }
    return self;
}

-(void)draw:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, self.fillColor);
    CGContextSetStrokeColorWithColor(context, self.lineColor);
    // Fonts
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSelectFont (context, "Helvetica-Bold",self.fontSize, kCGEncodingMacRoman);
    
    CGContextSetLineWidth(context, self.lineWidth);
    [self paint:context];
    CGContextRestoreGState(context);
}

-(void)paint:(CGContextRef)context {
    // Do nothing
}

@end
