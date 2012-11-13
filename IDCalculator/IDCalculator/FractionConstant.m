//
//  FractionConstant.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FractionConstant.h"
#import "IntegerConstant.h"

@implementation FractionConstant

- (FractionConstant*) init:(IntegerConstant*) numerator denominator:(IntegerConstant*) denominator {
    self = [super init];
    if(self) {
        [self setDenominator:denominator];
        [self setNumerator:numerator];
    }
    return self;
}

+ (Constant*) construct:(Constant *)n denominator:(Constant *)d {
    IntegerConstant* ZERO = [IntegerConstant ZERO];
    if([n class] == [IntegerConstant class] && [d class] == [IntegerConstant class]) {
        if(n == ZERO) {
            return ZERO;
        }
        IntegerConstant* icn = (IntegerConstant*)n;
        IntegerConstant* icd = (IntegerConstant*)d;
        if([icn value] % [icd value] == 0)
            return [IntegerConstant construct:[icn value]/[icd value]];
        NSInteger gcd = [FractionConstant gcd:[icn value]b:[icd value]];
        if(gcd!= 1) {
            [icn setValue:[icn value]/gcd];
            [icd setValue:[icd value]/gcd];
        }
        return [[FractionConstant alloc] init:icn denominator:icd];
    }
    if([n class] == [IntegerConstant class] && [d class] == [FractionConstant class]) {
        IntegerConstant* icn = (IntegerConstant*)n;
        FractionConstant* fcd = (FractionConstant*)d;
        return [FractionConstant construct:[icn mul:[fcd denominator]] denominator:[fcd numerator]];
    }
    if([n class] == [FractionConstant class] && [d class] == [IntegerConstant class]) {
        FractionConstant* fcn = (FractionConstant*)n;
        IntegerConstant* icd = (IntegerConstant*)d;
        return [FractionConstant construct:[fcn numerator] denominator:[[fcn denominator] mul:icd]];
    }
    if([n class] == [FractionConstant class] && [d class] == [FractionConstant class]) {
        FractionConstant* fcn = (FractionConstant*)n;
        FractionConstant* fcd = (FractionConstant*)d;
        return [FractionConstant construct:[[fcn numerator] mul:[fcd denominator]] denominator:[[fcn denominator] mul:[fcd numerator]]];
    }
    return nil;
}

-(Constant*) add:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        IntegerConstant* ic = (IntegerConstant*)input;
        return [FractionConstant construct:[[ic mul:[self denominator]] add:[self numerator]] denominator:[self denominator]];
    } else if([input class] == [FractionConstant class]) {
        FractionConstant* fc = (FractionConstant*)input;
        
        Constant* denominator = [[self denominator] mul:[fc denominator]];
        Constant* numLeft = [[fc numerator] mul:[self denominator]];
        Constant* numRight = [[fc denominator] mul:[self numerator]];
        
        return [FractionConstant construct:[numLeft add:numRight] denominator:denominator];
    }
    return nil;
}

-(Constant*) sub:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        IntegerConstant* ic = (IntegerConstant*)input;
        return [FractionConstant construct:[[self numerator] sub:[ic mul:[self denominator]]] denominator:[self denominator]];
    } else if([input class] == [FractionConstant class]) {
        FractionConstant* fc = (FractionConstant*)input;
        Constant* denominator = [[self denominator] mul:[fc denominator]];
        Constant* numLeft = [[self numerator] mul:[fc denominator]];
        Constant* numRight = [[self denominator] mul:[fc numerator]];
        return [FractionConstant construct:[numLeft sub:numRight] denominator:denominator];

    }
    return nil;
}

-(Constant*) mul:(Constant *)input {
    if([input class] == [IntegerConstant class]) {
        IntegerConstant* ic = (IntegerConstant*)input;
        return [FractionConstant construct:[ic mul:[self numerator]] denominator:[self denominator]];
    } else if([input class] == [FractionConstant class]) {
        FractionConstant* fc = (FractionConstant*)input;
        return [FractionConstant construct:[[self numerator] mul:[fc numerator]] denominator:[[self denominator] mul:[fc denominator]]];
    }
    return nil;
}

-(Constant*) div:(Constant *)input {
    return [FractionConstant construct:self denominator:input];
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
