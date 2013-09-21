//
//  BasicFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFuncExpression.h"
#import "ArithmeticExpression.h"
#import "Number.h"
#import "Integer.h"
#import "Decimal.h"
#import "SpecialConstant.h"
#import "ExpPowerExpression.h"
#import "PolynomialExpression.h"
#import "VariableContext.h"
#include "math.h"

@implementation BasicFuncExpression

-(BasicFuncExpression*) init: (BasicFuncType) type base:(Expression*)base {
    self = [super init];
    if(self) {
        [self setType:type];
        [self setBase:base];
    }
    return self;
}

-(Expression*) evaluate {
    if([[VariableContext instance] isTrue:KEY_CALCULATE]) {
        Expression* value = [self.base evaluate];
        if(![value isKindOfClass:[Decimal class]])
            return nil;
        Decimal* dec = (Decimal*)value;
        switch(self.type) {
            case BT_SIN:
                return [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithDouble: sin([[dec value] doubleValue])]];
            case BT_COS:
                return [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithDouble: cos([[dec value] doubleValue])]];
            case BT_LN:
                return [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithDouble: log([[dec value] doubleValue])]];
            default:
                return nil;
        }
    } else {
        self.base = [self.base evaluate];
        switch(self.type) {
            case BT_SIN:
                if(self.base == [Integer ZERO]) {
                    return [Integer ZERO];
                }
                if(self.base == [SpecialConstant PI]) {
                    return [Integer ZERO];
                }
                if([self.base isKindOfClass:[ArithmeticExpression class]]) {
                    // TODO Not implemented
                    // should implement special values
                }
                break;
            case BT_COS:
                if(self.base == [Integer ZERO]) {
                    return [Integer ONE];
                }
                if(self.base == [SpecialConstant PI]) {
                    return [Integer construct:-1];
                }
                if([self.base isKindOfClass:[ArithmeticExpression class]]) {
                    // TODO Not implemented
                    // should implement special values
                }
                break;
            case BT_LN:
                if(self.base == [SpecialConstant E]) {
                    return [Integer ONE];
                }
                if(self.base == [Integer ONE]) {
                    return [Integer ZERO];
                }
                if([self.base isKindOfClass:[ExpPowerExpression class]]) {
                    return [(ExpPowerExpression*)self.base power];
                }
                break;
        }
        return self;
    }
}

-(Expression*) differentiate:(Variable *) variable{
    Expression* inner = [self.base differentiate:variable];
    Expression* transformed = nil;
    switch ([self type]) {
        case BT_SIN:
            transformed = [[BasicFuncExpression alloc] init:BT_COS base:[self base]];
            break;
        case BT_COS:
            transformed = [[ArithmeticExpression alloc] init:nil opr:SUB right:[[BasicFuncExpression alloc] init:BT_SIN base:[self base]]];
            break;
        case BT_LN:
            transformed = [[ArithmeticExpression alloc] init:[Integer ONE] opr:DIV right:[self base]];
            break;
        default:
            return nil;
    }
    return [[ArithmeticExpression alloc] init:inner opr:MUL right:transformed];
}

-(Expression*) integrate:(Variable *)variable {
    Expression* pf = [PolynomialExpression toPolynomial:self.base under:variable];
    if([pf isKindOfClass:[PolynomialExpression class]]) {
        PolynomialExpression* poly = (PolynomialExpression*)pf;
        if([poly order] == 1) {
            Data* coefficient = [[Integer ONE] div:[poly getCoefficient:[poly order]]];
            Expression* result = nil;
            switch(self.type) {
                case BT_SIN:
                    result = [[ArithmeticExpression alloc] init:nil opr:SUB right:[[BasicFuncExpression alloc] init:BT_COS base:poly]];
                    break;
                case BT_COS:
                    result = [[BasicFuncExpression alloc] init:BT_SIN base:poly];
                    break;
                case BT_LN: {
                    // ∫ln(x)dx = ln(x)*x - x
                    Expression* lnpart = [[BasicFuncExpression alloc] init:BT_LN base:poly];
                    Expression* firstLn = [[ArithmeticExpression alloc] init:lnpart opr:MUL right:poly];
                    result = [[ArithmeticExpression alloc] init:firstLn opr:SUB right:poly];
                    break;
                }
                default:
                    result = nil;
            }
            if(nil != result) {
                result = [[ArithmeticExpression alloc] init:coefficient opr:MUL right:result];
                return result;
            } else {
                return nil;
            }
        } else {
            // Higher Order, no solution
            return nil;
        }
    } else {
        // Not polynomial format, no solution
        return nil;
    }
}

-(NSString *) description {
    NSString* funcName = nil;
    switch(self.type) {
        case BT_COS:
            funcName = @"cos";
            break;
        case BT_SIN:
            funcName = @"sin";
            break;
        case BT_LN:
            funcName = @"ln";
            break;
    }
    return [NSString stringWithFormat:@"%@(%@)",funcName,[self.base description]];
}

@end
