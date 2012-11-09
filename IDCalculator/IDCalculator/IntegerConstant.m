//
//  IntegerConstant.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "IntegerConstant.h"
#import "FractionConstant.h"

@implementation IntegerConstant

static IntegerConstant* ZERO;
static IntegerConstant* ONE;

+(void) initialize {
    if([self class] == [IntegerConstant class]) {
        ZERO = [[IntegerConstant alloc] init:0];
        ONE = [[IntegerConstant alloc] init:1];
    }
}

-(IntegerConstant*) init: (NSInteger)value {
    self = [super init];
    if(self){
        [self setValue:value];
    }
    return self;
}

-(Constant*)add:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        NSInteger value = [self value] + [(IntegerConstant*)input value];
        return [IntegerConstant construct:value];
    }
    return [input add:self];
}

-(Constant*)sub:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        NSInteger value = [self value] - [(IntegerConstant*)input value];
        return [IntegerConstant construct:value];
    }
    if ([input class] == [FractionConstant class]) {
        FractionConstant* fc = (FractionConstant*)input;
        Constant* n = [self mul:[fc denominator]];
        return [FractionConstant construct:[n sub:[fc numerator]] denominator:[fc denominator]];
    }
    return nil;
}

-(Constant*)mul:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        NSInteger value = [self value] * [(IntegerConstant*)input value];
        return [IntegerConstant construct:value];
    }
    return [input mul:self];
}

-(Constant*)div:(Constant *)input {
    return [FractionConstant construct:self denominator:input];
}

+(IntegerConstant*) construct:(NSInteger)input {
    if( input == 0)
        return ZERO;
    if(input == 1)
        return ONE;
    return [[IntegerConstant alloc] init:input];
}

+(IntegerConstant*) ZERO {
    return ZERO;
}

+(IntegerConstant*) ONE {
    return ONE;
}

@end
