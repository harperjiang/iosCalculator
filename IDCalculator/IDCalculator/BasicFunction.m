//
//  BasicFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFunction.h"
#import "ArithmeticFunction.h"
#import "NumConstant.h"
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
        case BT_SIN:
            transformed = [[BasicFunction alloc] init:BT_COS base:[self base]];
            break;
        case BT_COS:
            transformed = [[ArithmeticFunction alloc] init:nil opr:SUB right:[[BasicFunction alloc] init:BT_SIN base:[self base]]];
            break;
        case BT_LN:
            transformed = [[ArithmeticFunction alloc] init:[NumConstant ONE] opr:DIV right:[self base]];
            break;
        default:
            return nil;
    }
    return [Cleaner clean:[[ArithmeticFunction alloc] init:inner opr:MUL right:transformed]];
}

@end
