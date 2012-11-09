//
//  PowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PowerFunction.h"
#import "IntegerConstant.h"
#import "ArithmeticFunction.h"
#import "Cleaner.h"

@implementation PowerFunction

-(PowerFunction*) init:(Function *)base power:(Constant *)power {
    self = [super init];
    if(self) {
        [self setBase:base];
        [self setPower:power];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    // (f(x)^b)' = bf(x)^(b-1)*f(x)'
    Function* dbase = [[self base] differentiate:variable];
    Function* newPower = [[PowerFunction alloc] init:[self base] power:[[self power] sub:[IntegerConstant ONE]]];
    Function* bfx = [[ArithmeticFunction alloc] init:[self power] operator:MUL right:newPower];
    Function* result = [[ArithmeticFunction alloc] init:bfx operator:MUL right:dbase];
    
    return [Cleaner clean:result];
}

@end
