//
//  Fraction.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Fraction.h"
#import "Integer.h"
#import "NumberOperators.h"

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
        NSInteger icnval = [(Integer*)n value];
        NSInteger icdval = [(Integer*)d value];
        if(icnval < 0 && icdval < 0) {
            icnval = abs(icnval);
            icdval = abs(icdval);
        }
        if(icnval > 0 && icdval < 0) {
            icnval = -icnval;
            icdval = -icdval;
        }
        Integer* icn = [Integer construct:icnval];
        Integer* icd = [Integer construct:icdval];
        if([icn value] % [icd value] == 0)
            return [Integer construct:[icn value]/[icd value]];
        NSInteger gcd = [Fraction gcd:abs([icn value]) b:abs([icd value])];
        if(gcd!= 1) {
            [icn setValue:[icn value]/gcd];
            [icd setValue:[icd value]/gcd];
        }
        return [[Fraction alloc] init:icn denominator:icd];
    }
    if([n class] == [Integer class] && [d class] == [Fraction class]) {
        Integer* icn = (Integer*)n;
        Fraction* fcd = (Fraction*)d;
        return [Fraction construct:(Number*)[icn mul:[fcd denominator]] denominator:[fcd numerator]];
    }
    if([n class] == [Fraction class] && [d class] == [Integer class]) {
        Fraction* fcn = (Fraction*)n;
        Integer* icd = (Integer*)d;
        return [Fraction construct:[fcn numerator] denominator:(Number*)[[fcn denominator] mul:icd]];
    }
    if([n class] == [Fraction class] && [d class] == [Fraction class]) {
        Fraction* fcn = (Fraction*)n;
        Fraction* fcd = (Fraction*)d;
        return [Fraction construct:(Number*)[[fcn numerator] mul:[fcd denominator]] denominator:(Number*)[[fcn denominator] mul:[fcd numerator]]];
    }
    return nil;
}

-(Number*) add:(Number *)input {
//    if([input class] == [Integer class]) {
//        Integer* ic = (Integer*)input;
//        return [Fraction construct:[[ic mul:[self denominator]] add:[self numerator]] denominator:[self denominator]];
//    } else
    if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        
        Number* denominator = (Number*)[[self denominator] mul:[fc denominator]];
        Number* numLeft = (Number*)[[fc numerator] mul:[self denominator]];
        Number* numRight = (Number*)[[fc denominator] mul:[self numerator]];
        
        return [Fraction construct:(Number*)[numLeft add:numRight] denominator:denominator];
    }
    return [NumberOperators add:self right:input];
}

-(Number*) sub:(Number *)input {
//    if([input class] == [Integer class]) {
//        Integer* ic = (Integer*)input;
//        return [Fraction construct:[[self numerator] sub:[ic mul:[self denominator]]] denominator:[self denominator]];
//    } else
    if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        Number* denominator = (Number*)[[self denominator] mul:[fc denominator]];
        Number* numLeft = (Number*)[[self numerator] mul:[fc denominator]];
        Number* numRight = (Number*)[[self denominator] mul:[fc numerator]];
        return [Fraction construct:(Number*)[numLeft sub:numRight] denominator:denominator];
        
    }
    return [NumberOperators sub:self right:input];
}

-(Number*) mul:(Number *)input {
//    if([input class] == [Integer class]) {
//        Integer* ic = (Integer*)input;
//        return [Fraction construct:[ic mul:[self numerator]] denominator:[self denominator]];
//    } else
    if([input class] == [Fraction class]) {
        Fraction* fc = (Fraction*)input;
        return [Fraction construct:(Number*)[[self numerator] mul:[fc numerator]] denominator:(Number*)[[self denominator] mul:[fc denominator]]];
    }
    return [NumberOperators mul:self right:input];
}

-(Number*) div:(Number *)input {
    if([input class] == [Fraction class]) {
        return [Fraction construct:self denominator:input];
    }
    return [NumberOperators div:self right:input];
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
