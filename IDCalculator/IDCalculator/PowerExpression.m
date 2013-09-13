//
//  PowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PowerExpression.h"
#import "ArithmeticExpression.h"
#import "PolynomialExpression.h"
#import "Operator.h"
#import "Integer.h"
#import "Number.h"

@implementation PowerExpression

-(PowerExpression*) init:(Expression *)base power:(Number *)power {
    self = [super init];
    if(self) {
        [self setBase:base];
        [self setPower:power];
    }
    return self;
}

-(Expression*) differentiate:(Variable *)variable {
    // (f(x)^b)' = bf(x)^(b-1)*f(x)'
    Expression* dbase = [[self base] differentiate:variable];
    Expression* newPower = [[PowerExpression alloc] init:[self base] power:(Number*)[[self power] sub:[Integer ONE]]];
    Expression* bfx = [[ArithmeticExpression alloc] init:[self power] opr:MUL right:newPower];
    Expression* result = [[ArithmeticExpression alloc] init:bfx opr:MUL right:dbase];
    
    return result;
}

-(Expression*) integrate:(Variable *)variable {
    // Change to polynomial
    Expression* poly = [PolynomialExpression toPolynomial:self];
    return [poly integrate:variable];
}

-(Expression*) evaluate {
    self.base = [self.base evaluate];
    if(self.power == [Integer ONE])
        return self.base;
    if(self.power == [Integer ZERO])
        return [Integer ONE];
    if([self.base isKindOfClass:[PowerExpression class]]) {
        // Nested Power
        PowerExpression* oldbase = (PowerExpression*)self.base;
        self.base = oldbase.base;
        Expression* newpower = [[[ArithmeticExpression alloc] init:oldbase.power opr:ADD right:self.power] evaluate];
        if([newpower isKindOfClass:[Number class]]) {
            self.power = (Number*)newpower;
        } else {
            return nil;
        }
    }
    return self;
}

-(NSString *)description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if([self.base isKindOfClass:[ArithmeticExpression class]] || [self.base isKindOfClass:[PolynomialExpression class]])
        [result appendFormat:@"(%@)",[self.base description]];
    else
        [result appendString:[self.base description]];
    if([self.power isKindOfClass:[Number class]]) {
        Number* power = (Number*) self.power;
        
        NSString* powerstr = [PowerExpression stringForPower:power];
        if(powerstr != nil) {
            [result appendString:powerstr];
            return result;
        }
    }
    
    [result appendString:@"^"];
    if([self.power isKindOfClass:[ArithmeticExpression class]])
        [result appendFormat:@"(%@)",[self.power description]];
    else
        [result appendString:[self.power description]];
    return result;
    
}

+(NSString*) stringForPower:(Number*) con {
    if(![con isKindOfClass:[Integer class]])
        return [NSString stringWithFormat:@"^(%@)",[con description]];
    Integer* intval = (Integer*)con;
    NSInteger val = intval.value;
    
    switch(val) {
        case 0:
            return @"";
        case 1:
            return @"";
        case 2:
            return @"²";
        case 3:
            return @"³";
        case 4:
            return @"⁴";
        case 5:
            return @"⁵";
        case 6:
            return @"⁶";
        case 7:
            return @"⁷";
        case 8:
            return @"⁸";
        case 9:
            return @"⁹";
        default:
            return [NSString stringWithFormat:@"^%@",[con description]];
    }
    
    return @"";
}

@end
