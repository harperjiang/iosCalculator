//
//  Stack.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/15/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(Stack*) init {
    self = [super init];
    if(self) {
        [self setContent:[[NSMutableArray alloc] initWithCapacity:10]];
        [self setPointer:0];
    }
    return self;
}

-(void) push:(id)element {
    [[self content] addObject:element];
    [self setPointer:[self pointer]+1];
}

-(id) pop {
    if([self pointer] == 0)
        return nil;
    [self setPointer:[self pointer]-1];
    id object = [[self content]objectAtIndex:[self pointer]];
    [[self content] removeObjectAtIndex:[self pointer]];
    return object;
}

-(id) peek {
    if([self pointer] == 0)
        return nil;
    return [[self content] objectAtIndex:[self pointer]-1];
}

@end
