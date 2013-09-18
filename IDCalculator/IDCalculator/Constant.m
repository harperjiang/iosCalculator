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
#import "ArithConstant.h"
#import "PolynomialExpression.h"

@implementation Constant

-(Expression*) evaluate {
    return self;
}

-(Decimal*) toDecimal {
    return nil;
}

-(Expression*) differentiate:(Variable *)variable {
    return [Integer ZERO];
}

-(Expression *)integrate:(Variable *)variable {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
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
