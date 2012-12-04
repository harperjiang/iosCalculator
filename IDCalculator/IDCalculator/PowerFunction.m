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

-(Function*) evaluate {
    self.base = [self.base evaluate];
    if(self.power == [NumConstant ONE])
        return self.base;
    if(self.power == [NumConstant ZERO])
        return [NumConstant ONE];
    return self;
}

-(NSString *)description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if([self.base isKindOfClass:[ArithmeticFunction class]])
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
        return nil;
    Integer* intval = (Integer*)con.number;
    NSInteger val = intval.value;
    if(val > 1 && val < 10) {
        switch(val) {
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
                return nil;
        }
    }
    return nil;
}

@end
