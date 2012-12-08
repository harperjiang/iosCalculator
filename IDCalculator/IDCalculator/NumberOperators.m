//
//  NumberOperators.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "NumberOperators.h"
#import "Integer.h"
#import "Fraction.h"
#import "Decimal.h"

extern short DEFAULT_ROUND;

@implementation NumberOperators

+(Number*) add:(Number*) left right:(Number*) right {
    if([self level:left] < [self level:right]) {
        return [[self convert:left type:[self level:right]] add:right];
    } else if([self level:left] > [self level:right]) {
        return [left add:[self convert:right type:[self level:left]]];
    } else {
        return [left add:right];
    }
}

+(Number*) sub:(Number*) left right:(Number*) right {
    if([self level:left] < [self level:right]) {
        return [[self convert:left type:[self level:right]] sub:right];
    } else if([self level:left] > [self level:right]) {
        return [left sub:[self convert:right type:[self level:left]]];
    } else {
        return [left sub:right];
    }
}

+(Number*) mul:(Number*) left right:(Number*) right {
    if([self level:left] < [self level:right]) {
        return [[self convert:left type:[self level:right]] mul:right];
    } else if([self level:left] > [self level:right]) {
        return [left mul:[self convert:right type:[self level:left]]];
    } else {
        return [left mul:right];
    }
}

+(Number*) div:(Number*) left right:(Number*) right {
    if([self level:left] < [self level:right]) {
        return [[self convert:left type:[self level:right]] div:right];
    } else if([self level:left] > [self level:right]) {
        return [left div:[self convert:right type:[self level:left]]];
    } else {
        return [left div:right];
    }
}

+(NSInteger) level:(Number*) input {
    if([input isKindOfClass:[Integer class]])
        return 1;
    if([input isKindOfClass:[Fraction class]])
        return 2;
    if([input isKindOfClass:[Decimal class]])
        return 3;
    return 0;
}

+(Number*) convert:(Number*) input type:(NSInteger) type{
    NSInteger current = [self level:input];
    if(current == 1 && type == 2) {
        return [[Fraction alloc] init:(Integer*)input denominator:[Integer ONE]];
    }
    if(current == 1 && type == 3) {
        NSDecimalNumber* dn = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:[(Integer*)input value]];
        return [[Decimal alloc] init:dn];
    }
    if(current == 2 && type == 3) {
        Fraction* finput = (Fraction*)input;
        NSDecimalNumber* num = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:((Integer*)finput.numerator).value];
        NSDecimalNumber* denom = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:((Integer*)finput.denominator).value];
        return [[Decimal alloc] init:[num decimalNumberByDividingBy:denom withBehavior:[ScaleBehavior get:4]]];
    }
    return nil;
}

@end