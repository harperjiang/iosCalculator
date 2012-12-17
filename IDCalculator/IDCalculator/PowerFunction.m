//
//  PowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PowerFunction.h"
#import "NumConstant.h"
#import "ArithmeticFunction.h"
#import "PolynomialFunction.h"
#import "Integer.h"
#import "Number.h"

@implementation PowerFunction

-(PowerFunction*) init:(Function *)base power:(Constant *)power {
    self = [super init];
    if(self) {
        [self setBase:base];
        [self setPower:power];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    // (f(x)^b)' = bf(x)^(b-1)*f(x)'
    Function* dbase = [[self base] differentiate:variable];
    Function* newPower = [[PowerFunction alloc] init:[self base] power:[[self power] sub:[NumConstant ONE]]];
    Function* bfx = [[ArithmeticFunction alloc] init:[self power] opr:MUL right:newPower];
    Function* result = [[ArithmeticFunction alloc] init:bfx opr:MUL right:dbase];
    
    return result;
}

-(Function*) integrate:(Variable *)variable {
    // Change to polynomial
    Function* poly = [PolynomialFunction toPolynomial:self];
    return [poly integrate:variable];
}

-(Function*) evaluate {
    self.base = [self.base evaluate];
    if(self.power == [NumConstant ONE])
        return self.base;
    if(self.power == [NumConstant ZERO])
        return [NumConstant ONE];
    if([self.base isKindOfClass:[PowerFunction class]]) {
        // Nested Power
        PowerFunction* oldbase = (PowerFunction*)self.base;
        self.base = oldbase.base;
        Function* newpower = [[[ArithmeticFunction alloc] init:oldbase.power opr:ADD right:self.power] evaluate];
        if([newpower isKindOfClass:[NumConstant class]]) {
            self.power = (NumConstant*)newpower;
        } else {
            return nil;
        }
    }
    return self;
}

-(NSString *)description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if([self.base isKindOfClass:[ArithmeticFunction class]] || [self.base isKindOfClass:[PolynomialFunction class]])
        [result appendFormat:@"(%@)",[self.base description]];
    else
        [result appendString:[self.base description]];
    if([self.power isKindOfClass:[NumConstant class]]) {
        NumConstant* power = (NumConstant*) self.power;
        
        NSString* powerstr = [PowerFunction stringForPower:power];
        if(powerstr != nil) {
            [result appendString:powerstr];
            return result;
        }
    }
    
    [result appendString:@"^"];
    if([self.power isKindOfClass:[ArithmeticFunction class]])
        [result appendFormat:@"(%@)",[self.power description]];
    else
        [result appendString:[self.power description]];
    return result;
    
}

+(NSString*) stringForPower:(NumConstant*) con {
    if(![con.number isKindOfClass:[Integer class]])
        return [NSString stringWithFormat:@"^(%@)",[con description]];
    Integer* intval = (Integer*)con.number;
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
