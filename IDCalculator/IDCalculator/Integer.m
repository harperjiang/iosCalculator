//
//  Integer.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Integer.h"
#import "Fraction.h"
#import "NumberOperators.h"
#import "Decimal.h"

@implementation Integer


static Integer* ZERO;
static Integer* ONE;
static Integer* NEGAONE;

+(void) initialize {
    if([self class] == [Integer class]) {
        ZERO = [[Integer alloc] init:0];
        ONE = [[Integer alloc] init:1];
        NEGAONE = [[Integer alloc] init:-1];
    }
}

-(Integer*) init: (NSInteger)value {
    self = [super init];
    if(self){
        [self setValue:value];
    }
    return self;
}

-(Number*) add:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] + [(Integer*)input value];
        return [Integer construct:value];
    }
    return [NumberOperators add:self right:input];
}

-(Number*) sub:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] - [(Integer*)input value];
        return [Integer construct:value];
    }
    return [NumberOperators sub:self right:input];
//    if ([input class] == [Fraction class]) {
//        Fraction* fc = (Fraction*)input;
//        Number* n = [self mul:[fc denominator]];
//        return [Fraction construct:[n sub:[fc numerator]] denominator:[fc denominator]];
//    }
//    return nil;
}

-(Number*) mul:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] * [(Integer*)input value];
        return [Integer construct:value];
    }
    return [NumberOperators mul:self right:input];
}

-(Number*) div:(Number *)input {
    if([input class] == [Integer class]) {
        return [Fraction construct:self denominator:input];
    }
    return [NumberOperators div:self right:input];
}

-(Number*) mod:(Number *)input {
    if([input class] == [Integer class]) {
        Integer* inp = (Integer*)input;
        return [Integer construct: self.value % inp.value];
    }
    return nil;
}

-(Decimal*) toDecimal {
    return [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithInteger:[self value]]];
}

+(Integer*) construct:(NSInteger)input {
    if( input == 0)
        return ZERO;
    if(input == 1)
        return ONE;
    if(input == -1)
        return NEGAONE;
    return [[Integer alloc] init:input];
}

+(Integer*) ZERO {
    return ZERO;
}

+(Integer*) ONE {
    return ONE;
}

+(Integer *)NEGAONE {
    return NEGAONE;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%d",[self value]];
}


@end
