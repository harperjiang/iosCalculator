//
//  BasicFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFunction.h"
#import "ArithmeticFunction.h"
#import "IntegerConstant.h"
#import "Cleaner.h"

@implementation BasicFunction

-(BasicFunction*) init: (BasicFunctionType) type base:(Function*)base {
    self = [super init];
    if(self) {
        [self setType:type];
        [self setBase:base];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    Function* inner = [[self base] differentiate:variable];
    Function* transformed = nil;
    switch ([self type]) {
        case SIN:
            transformed = [[BasicFunction alloc] init:COS base:[self base]];
            break;
        case COS:
            transformed = [[ArithmeticFunction alloc] init:nil operator:SUB right:[[BasicFunction alloc] init:SIN base:[self base]]];
            break;
        case LN:
            transformed = [[ArithmeticFunction alloc] init:[IntegerConstant ONE] operator:DIV right:[self base]];
            break;
        default:
            return nil;
    }
    return [Cleaner clean:[[ArithmeticFunction alloc] init:inner operator:MUL right:transformed]];
}

@end
