//
//  ViewPort.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ViewPort.h"

CGFloat const DEFAULT_PROP = 0.05;
CGFloat const MIN_PROP = 0.001;
CGFloat const MAX_PROP = 1;

@implementation ViewPort

-(ViewPort*) init {
    self = [super init];
    if(self) {
        [self setProportion: DEFAULT_PROP];
        self->_center.x = 0;
        self->_center.y = 0;
        [self setEnvironment:[[Environment alloc] init]];
        [[self environment] setViewPort:self];
    }
    return self;
}

-(void) transform:(CGPoint*) input {
    input->x = input->x*[self proportion];
    input->y = -input->y*[self proportion];
}

-(void) paint:(CGContextRef)context {
    // Make a transform to origin point
    CGRect rect = CGContextGetClipBoundingBox(context);
    
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    CGContextScaleCTM(context, 1/[self proportion], -1/[self proportion]);
    CGContextTranslateCTM(context, -[self center].x, -[self center].y);
    // Set Text transformation
    CGContextSetTextMatrix(context, CGAffineTransformMake([self proportion], 0, 0, [self proportion], 0, 0));
    
    CGFloat width = rect.size.width/2 * [self proportion];
    CGFloat height = rect.size.height/2 * [self proportion];
    
    CGFloat bottom = [self center].y - height;
    CGFloat left = [self center].x - width;
    
    [[self environment] setLineWidth:[self proportion]];
    [[self environment] setRange: CGRectMake(left, bottom, 2*width, 2*height)];
    [[self environment] draw:context];
}

@end
