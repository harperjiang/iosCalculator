//
//  ArithmeticExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticExpression.h"
#import "NumberData.h"
#import "Integer.h"
#import "Matrix.h"

@implementation ArithmeticExpression

-(ArithmeticExpression*) init:(Expression *)left operator:(Operator)opr right:(Expression *)right {
    self = [super init];
    if(self) {
        [self setLeft:left];
        [self setRight: right];
        [self setOpr:opr];
    }
    return self;
}

-(Data*) evaluate {
    Data* leftData = nil;
    if([self left] == nil) {
        leftData = [[NumberData alloc] init:[Integer ZERO]];
    } else {
        leftData = [[self left] evaluate];
    }
    Data* rightData = [[self right] evaluate];
    switch([self opr]) {
        case ADD:
            return [leftData add:rightData];
        case SUB:
            return [leftData sub:rightData];
        case MUL:
            return [leftData mul:rightData];
        case DIV:
            return [leftData div:rightData];
        default:
            return nil;
    }
}

@end
