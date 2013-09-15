//
//  Element.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Element.h"
#import "Environment.h"
#import "ViewPort.h"

@implementation Element

-(void) setRange:(CGRect) r {
    self->_range.origin.x = r.origin.x;
    self->_range.origin.y = r.origin.y;
    self->_range.size.width = r.size.width;
    self->_range.size.height = r.size.height;
}

-(Environment*) environment {
    Element* pointer = self;
    while([pointer parent] != nil) {
        if([[pointer parent] isKindOfClass:[Environment class]]) {
            return (Environment*)[pointer parent];
        }
        pointer = [pointer parent];
    }
    return nil;
}

/*
 * Translate the given value to scaled value. 
 */
-(CGFloat) translate: (CGFloat) input {
    if([self environment] == nil)
        return input;
    CGFloat proportion = [[[self environment] viewPort] proportion];
    return proportion * input;
}

@end
