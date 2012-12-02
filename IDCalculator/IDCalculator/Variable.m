//
//  Variable.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Variable.h"

@implementation Variable

static Variable* x;

+(void)initialize {
    if([self class] == [Variable class]) {
        x = [[Variable alloc] init];
        x.name = @"x";
    }
}

+(Variable*) x {
    return x;
}

@end
