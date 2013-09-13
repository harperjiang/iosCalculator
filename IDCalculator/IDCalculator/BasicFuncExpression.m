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
#import "Integer.h"
#import "SpecialConstant.h"
#import "ExpPowerFunction.h"
#import "PolynomialFunction.h"

@implementation BasicFunction

-(BasicFunction*) init: (BasicFunctionType) type base:(Function*)base {
    self = [super init];
    if(self) {
        [self setType:type];
        [self setBase:base];
    }
    return self;
}

-(Function*) evaluate {
    self.base = [self.base evaluate];
    switch(self.type) {
        case BT_SIN:
            if(self.base == [NumConstant ZERO]) {
                return [NumConstant ZERO];
            }
            if(self.base == [SpecialConstant PI]) {
                return [NumConstant ZERO];
            }
            if([self.base isKindOfClass:[ArithmeticFunction class]]) {
                
            }
            break;
        case BT_COS:
            if(self.base == [NumConstant ZERO]) {
                return [NumConstant ONE];
            }
            if(self.base == [SpecialConstant PI]) {
                return [NumConstant construct:[Integer construct:-1]];
            }
            if([self.base isKindOfClass:[ArithmeticFunction class]]) {
                
            }
            break;
        case BT_LN:
            if(self.base == [SpecialConstant E]) {
                return [NumConstant ONE];
            }
            if([self.base isKindOfClass:[ExpPowerFunction class]]) {
                return [(ExpPowerFunction*)self.base power];
            }
            break;
    }
    return self;
}

-(Function*) differentiate:(Variable *) variable{
    Function* inner = [self.base differentiate:variable];
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
    return [[ArithmeticFunction alloc] init:inner opr:MUL right:transformed];
}

-(Function*) integrate:(Variable *)variable {
    Function* pf = [PolynomialFunction toPolynomial:self.base under:variable];
    if([pf isKindOfClass:[PolynomialFunction class]]) {
        PolynomialFunction* poly = (PolynomialFunction*)pf;
        if([poly order] == 1) {
            Constant* coefficient = [[NumConstant ONE] div:[poly getCoefficient:[poly order]]];
            Function* result = nil;
            switch(self.type) {
                case BT_SIN:
                    result = [[ArithmeticFunction alloc] init:nil opr:SUB right:[[BasicFunction alloc] init:BT_COS base:poly]];
                    break;
                case BT_COS:
                    result = [[BasicFunction alloc] init:BT_SIN base:poly];
                    break;
                case BT_LN: {
                    // ∫ln(x)dx = ln(x)*x - x
                    Function* lnpart = [[BasicFunction alloc] init:BT_LN base:poly];
                    Function* firstLn = [[ArithmeticFunction alloc] init:lnpart opr:MUL right:poly];
                    result = [[ArithmeticFunction alloc] init:firstLn opr:SUB right:poly];
                    break;
                }
                default:
                    result = nil;
            }
            if(nil != result) {
                result = [[ArithmeticFunction alloc] init:coefficient opr:MUL right:result];
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
