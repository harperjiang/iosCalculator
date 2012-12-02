//
//  ExpPowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpPowerFunction.h"
#import "ArithmeticFunction.h"
#import "Cleaner.h"

@implementation ExpPowerFunction

-(ExpPowerFunction*) init:(Function *)power {
    self = [super init];
    if(self) {
        [self setPower:power];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    // e^f(x) = e^f(x) *f'(x)
    Function* dpower = [[self power] differentiate:variable];
    Function* result = [[ArithmeticFunction alloc] init:self opr:MUL right:dpower];
    return [Cleaner clean:result];
}

@end
