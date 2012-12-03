//
//  ExpressionList.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpressionList.h"

@implementation ExpressionList

-(ExpressionList*) init {
    self = [super init];
    if(self) {
        [self setExpList:[[NSMutableArray alloc] initWithCapacity:20]];
    }
    return self;
}

-(void) add:(Expression *)exp {
    [[self expList] addObject:exp];
}

-(Expression*) get:(NSInteger)index {
    return [[self expList] objectAtIndex:index];
}

-(void)set:(NSInteger)index value:(Expression *)val {
    [self.expList setObject:val atIndexedSubscript:index];
}

-(NSInteger) count {
    return [[self expList] count];
}

@end
