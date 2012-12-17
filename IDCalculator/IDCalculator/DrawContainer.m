//
//  Environment.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DrawContainer.h"

@implementation DrawContainer {
    
    NSMutableArray* objects;
}

-(id)init {
    self = [super init];
    if(self) {
        self->objects = [[NSMutableArray alloc] initWithCapacity:40];
    }
    return self;
}

-(void)addObject:(id<Drawable>)object {
    [self->objects addObject:object];
}

-(void)removeObject:(id<Drawable>)object {
    [self->objects removeObject:object];
}

-(void)draw:(CGContextRef)context {
    CGContextSaveGState(context);
    for(int i = 0 ; i < [self->objects count]; i++) {
        [[self->objects objectAtIndex:i] draw:context];
    }
    CGContextRestoreGState(context);
}

@end
