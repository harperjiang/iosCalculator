//
//  Constant.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"
#import "Integer.h"
#import "Operator.h"
#import "NumConstant.h"
#import "ArithConstant.h"
#import "PolynomialFunction.h"

@implementation Constant

-(Function*) evaluate {
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    return [NumConstant ZERO];
}

-(Function *)integrate:(Variable *)variable {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    [pf addItem:self power:1];
    return pf;
}

-(Constant*)add:(Constant *)input {
    return [[ArithConstant alloc] init:self opr:ADD right:input];
}

-(Constant*)sub:(Constant *)input {
    return [[ArithConstant alloc] init:self opr:SUB right:input];
}
-(Constant*)mul:(Constant *)input {
    return [[ArithConstant alloc] init:self opr:MUL right:input];
}
-(Constant*)div:(Constant *)input {
    return [[ArithConstant alloc] init:self opr:DIV right:input];
}


@end
