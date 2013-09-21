//
//  ExpPowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpPowerExpression.h"
#import "ArithmeticExpression.h"
#import "BasicFuncExpression.h"
#import "Number.h"
#import "PowerExpression.h"
#import "SpecialConstant.h"

@implementation ExpPowerExpression

-(ExpPowerExpression*) init:(Number*) base power:(Expression *) power {
    self = [super init];
    if(self) {
        [self setBase:base];
        [self setPower:power];
    }
    return self;
}

-(ExpPowerExpression*) init:(Expression *)power {
    return [self init:[SpecialConstant E] power:power];
}

-(Expression*) differentiate:(Variable *)variable {
    // e^f(x) = e^f(x) *f'(x)
    Expression* dpower = [[self power] differentiate:variable];
    Expression* result = [[ArithmeticExpression alloc] init:self opr:MUL right:dpower];
    if(self.base == [SpecialConstant E])
        return result;
    BasicFuncExpression* ln = [[BasicFuncExpression alloc] init:BT_LN base:self.base];
    return [[ArithmeticExpression alloc] init: ln opr:MUL right:result];
}

-(Expression*) integrate:(Variable *)variable {
    // TODO Not implemented
    return nil;
}

-(Expression*) evaluate {
    self.power = [self.power evaluate];
    return self;
}

-(NSString*) description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:20];
    [buffer appendString:[self.base description]];
    if([self.power isKindOfClass:[Number class]]) {
        NSString* powerstr = [PowerExpression stringForPower:(Number*)self.power];
        if(powerstr != nil) {
            [buffer appendString:powerstr];
            return buffer;
        }
    }
    if([self.power isKindOfClass:[Number class]]) {
        [buffer appendFormat:@"^%@",[self.power description]];
    } else {
        [buffer appendFormat:@"^(%@)",[self.power description]];
    }
    return buffer;
}

@end
