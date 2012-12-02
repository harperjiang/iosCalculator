//
//  ArithmeticFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunction.h"
#import "Cleaner.h"
#import "NumConstant.h"

@implementation ArithmeticFunction

-(ArithmeticFunction*) init: (Function*)left opr:(Operator) opr right:(Function*) right {
    self = [super init];
    if(self) {
        if(left == nil)
            left = [NumConstant ZERO];
        [self setLeft:left];
        [self setRight:right];
        [self setOpr:opr];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    Function* du = [[self left] differentiate:variable];
    Function* dv = [[self right] differentiate:variable];
    Function* result = nil;
    Function* udv = nil, *vdu = nil,*uv = nil;
    if([self opr] >= MUL) {
        udv = [[ArithmeticFunction alloc] init:[self left] opr:MUL right:dv];
        vdu = [[ArithmeticFunction alloc] init:[self right] opr:MUL right:du];
        uv = [[ArithmeticFunction alloc] init:[self left] opr:MUL right:[self right]];
    }
    switch([self opr]) {
        case ADD:
        case SUB:
            // du +/- dv
            result = [[ArithmeticFunction alloc] init:du opr:[self opr] right:dv];
            break;
        case MUL:
            // udv + vdu
            result = [[ArithmeticFunction alloc] init:udv opr:ADD right:vdu];
            break;
        case DIV:
            // (udv - vdu)/uv
            result = [[ArithmeticFunction alloc] init:[[ArithmeticFunction alloc] init:udv opr:SUB right:vdu] opr:DIV right:uv];
            break;
        default:
            return nil;
    }
    
    return [Cleaner clean:result];
}

@end
