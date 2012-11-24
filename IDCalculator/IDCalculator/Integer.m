//
//  Integer.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Integer.h"
#import "Fraction.h"

@implementation Integer


static Integer* ZERO;
static Integer* ONE;

+(void) initialize {
    if([self class] == [Integer class]) {
        ZERO = [[Integer alloc] init:0];
        ONE = [[Integer alloc] init:1];
    }
}

-(Integer*) init: (NSInteger)value {
    self = [super init];
    if(self){
        [self setValue:value];
    }
    return self;
}

-(Number*)add:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] + [(Integer*)input value];
        return [Integer construct:value];
    }
    return [input add:self];
}

-(Number*)sub:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] - [(Integer*)input value];
        return [Integer construct:value];
    }
    if ([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        Number* n = [self mul:[fc denominator]];
        return [Fraction construct:[n sub:[fc numerator]] denominator:[fc denominator]];
    }
    return nil;
}

-(Number*)mul:(Number *)input {
    if([input class] == [Integer class]) {
        NSInteger value = [self value] * [(Integer*)input value];
        return [Integer construct:value];
    }
    return [input mul:self];
}

-(Number*)div:(Number *)input {
    return [Fraction construct:self denominator:input];
}

+(Integer*) construct:(NSInteger)input {
    if( input == 0)
        return ZERO;
    if(input == 1)
        return ONE;
    return [[Integer alloc] init:input];
}

+(Integer*) ZERO {
    return ZERO;
}

+(Integer*) ONE {
    return ONE;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%d",[self value]];
}


@end
