//
//  ArithmeticExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticExpression.h"
#import "Matrix.h"

@implementation ArithmeticExpression

-(ArithmeticExpression*) init:(Expression *)left operator:(Operator)opr right:(Expression *)right {
    self = [super init];
    if(self) {
        [self setLeft:left];
        [self setRight: right];
        [self setOperator:opr];
    }
    return self;
}

-(id) evaluate {
    Matrix* leftMatrix = (Matrix*)[[self left] evaluate];
    Matrix* rightMatrix = (Matrix*)[[self right] evaluate];
    switch([self operator]) {
        case MUL:
            return [leftMatrix mul:rightMatrix];
        default:
            return nil;
    }
}

@end
