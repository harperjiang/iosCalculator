//
//  ElementContainer.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ElementContainer.h"

@implementation ElementContainer

-(ElementContainer*) init {
    self = [super init];
    if(self) {
        [self setObjects:[[NSMutableArray alloc] init]];
    }
    return self;
}

-(void) addElement:(Element*)obj {
    [[self objects] addObject:obj];
    [obj setParent:self];
}

-(void) removeElement:(Element*)obj {
    [[self objects] removeObject:obj];
    [obj setParent:nil];
}

-(void)paint:(CGContextRef)context {
    /*
     CGContextBeginPath(context);
     CGContextMoveToPoint(context, 0, 0);
     CGContextAddLineToPoint(context, 10, 10);
     CGContextStrokePath(context);
     */
    for(int i = 0 ;i < [[self objects] count]; i++) {
        Element* pd = (Element*)[[self objects] objectAtIndex:i];
        [pd draw:context];
    }
}


@end
