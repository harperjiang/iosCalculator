//
//  ArithmeticFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunction.h"
#import "Cleaner.h"
#import "IntegerConstant.h"

@implementation ArithmeticFunction

-(ArithmeticFunction*) init: (Function*)left operator:(Operator) opr right:(Function*) right {
    self = [super init];
    if(self) {
        if(left == nil)
            left = [IntegerConstant ZERO];
        [self setLeft:left];
        [self setRight:right];
        [self setOperator:opr];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    Function* du = [[self left] differentiate:variable];
    Function* dv = [[self right] differentiate:variable];
    Function* result = nil;
    Function* udv = nil, *vdu = nil,*uv = nil;
    if([self operator] >= MUL) {
        udv = [[ArithmeticFunction alloc] init:[self left] operator:MUL right:dv];
        vdu = [[ArithmeticFunction alloc] init:[self right] operator:MUL right:du];
        uv = [[ArithmeticFunction alloc] init:[self left] operator:MUL right:[self right]];
    }
    switch([self operator]) {
        case ADD:
        case SUB:
            // du +/- dv
            result = [[ArithmeticFunction alloc] init:du operator:[self operator] right:dv];
            break;
        case MUL:
            // udv + vdu
            result = [[ArithmeticFunction alloc] init:udv operator:ADD right:vdu];
            break;
        case DIV:
            // (udv - vdu)/uv
            result = [[ArithmeticFunction alloc] init:[[ArithmeticFunction alloc] init:udv operator:SUB right:vdu] operator:DIV right:uv];
            break;
        default:
            return nil;
    }
    
    return [Cleaner clean:result];
}

@end
