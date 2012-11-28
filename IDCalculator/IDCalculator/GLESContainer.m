//
//  GLESContainer.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/27/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "GLESContainer.h"

@implementation GLESContainer {
    NSMutableArray* children;
}

-(GLESContainer*) init {
    self = [super init];
    if(self) {
        self->children = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) add:(GLESObject *)child {
    [self->children addObject:child];
}

-(void) remove:(GLESObject *)child {
    [self->children removeObject:child];
}

-(void) render {
    for(int i = 0 ; i < [children count]; i++)
        [(GLESObject*)[children objectAtIndex:i] render];
}

@end
