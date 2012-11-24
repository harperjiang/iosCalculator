//
//  Fraction.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Fraction.h"
#import "Integer.h"

@implementation Fraction

- (Fraction*) init:(Integer*) numerator denominator:(Integer*) denominator {
    self = [super init];
    if(self) {
        [self setDenominator:denominator];
        [self setNumerator:numerator];
    }
    return self;
}

+ (Number*) construct:(Number *)n denominator:(Number *)d {
    Integer* ZERO = [Integer ZERO];
    if([n class] == [Integer class] && [d class] == [Integer class]) {
        if(n == ZERO) {
            return ZERO;
        }
        Integer* icn = (Integer*)n;
        Integer* icd = (Integer*)d;
        if([icn value] % [icd value] == 0)
            return [Integer construct:[icn value]/[icd value]];
        NSInteger gcd = [Fraction gcd:[icn value]b:[icd value]];
        if(gcd!= 1) {
            [icn setValue:[icn value]/gcd];
            [icd setValue:[icd value]/gcd];
        }
        return [[Fraction alloc] init:icn denominator:icd];
    }
    if([n class] == [Integer class] && [d class] == [Fraction class]) {
        Integer* icn = (Integer*)n;
        Fraction* fcd = (Fraction*)d;
        return [Fraction construct:[icn mul:[fcd denominator]] denominator:[fcd numerator]];
    }
    if([n class] == [Fraction class] && [d class] == [Integer class]) {
        Fraction* fcn = (Fraction*)n;
        Integer* icd = (Integer*)d;
        return [Fraction construct:[fcn numerator] denominator:[[fcn denominator] mul:icd]];
    }
    if([n class] == [Fraction class] && [d class] == [Fraction class]) {
        Fraction* fcn = (Fraction*)n;
        Fraction* fcd = (Fraction*)d;
        return [Fraction construct:[[fcn numerator] mul:[fcd denominator]] denominator:[[fcn denominator] mul:[fcd numerator]]];
    }
    return nil;
}

-(Number*) add:(Number *)input {
    if([input class] == [Integer class]) {
        Integer* ic = (Integer*)input;
        return [Fraction construct:[[ic mul:[self denominator]] add:[self numerator]] denominator:[self denominator]];
    } else if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        
        Number* denominator = [[self denominator] mul:[fc denominator]];
        Number* numLeft = [[fc numerator] mul:[self denominator]];
        Number* numRight = [[fc denominator] mul:[self numerator]];
        
        return [Fraction construct:[numLeft add:numRight] denominator:denominator];
    }
    return nil;
}

-(Number*) sub:(Number *)input {
    if([input class] == [Integer class]) {
        Integer* ic = (Integer*)input;
        return [Fraction construct:[[self numerator] sub:[ic mul:[self denominator]]] denominator:[self denominator]];
    } else if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        Number* denominator = [[self denominator] mul:[fc denominator]];
        Number* numLeft = [[self numerator] mul:[fc denominator]];
        Number* numRight = [[self denominator] mul:[fc numerator]];
        return [Fraction construct:[numLeft sub:numRight] denominator:denominator];
        
    }
    return nil;
}

-(Number*) mul:(Number *)input {
    if([input class] == [Integer class]) {
        Integer* ic = (Integer*)input;
        return [Fraction construct:[ic mul:[self numerator]] denominator:[self denominator]];
    } else if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        return [Fraction construct:[[self numerator] mul:[fc numerator]] denominator:[[self denominator] mul:[fc denominator]]];
    }
    return nil;
}

-(Number*) div:(Number *)input {
    return [Fraction construct:self denominator:input];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%@/%@",[[self numerator] description],[[self denominator] description]];
}

+(NSInteger) gcd:(NSInteger)a b:(NSInteger)b {
    NSInteger small = MIN(a, b);
    NSInteger big = MAX(a,b);
    NSInteger temp = 0;
    while(small!= 1) {
        if(big%small == 0)
            return small;
        temp = big;
        big = small;
        small = temp%small;
    }
    return small;
}

@end
