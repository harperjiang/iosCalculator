//
//  Decimal.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Decimal.h"
#import "Integer.h"
#import "Fraction.h"
#import "NumberOperators.h"


short DEFAULT_ROUND = 10;
short DISPLAY_ROUND = 4;
short CALCULATE_ROUND = 10;

@implementation ScaleBehavior

static ScaleBehavior* DISPLAY;
static ScaleBehavior* CALCULATE;

+(void)initialize {
    if([self class] == [ScaleBehavior class]) {
        DISPLAY = [[ScaleBehavior alloc] init:DISPLAY_ROUND];
        CALCULATE = [[ScaleBehavior alloc] init:CALCULATE_ROUND];
    }
}

+(ScaleBehavior *)get:(short)scale {
    if(scale == DISPLAY_ROUND)
        return DISPLAY;
    if(scale == CALCULATE_ROUND)
        return CALCULATE;
    return [[ScaleBehavior alloc] init:scale];
}

// The scale could return NO_SCALE for no defined scale.
-(NSRoundingMode)roundingMode {
    return NSRoundPlain;
}

// Receiver can raise, return a new value, or return nil to ignore the exception.
- (NSDecimalNumber *)exceptionDuringOperation:(SEL)operation error:(NSCalculationError)error leftOperand:(NSDecimalNumber *)leftOperand rightOperand:(NSDecimalNumber *)rightOperand {
    return nil;
}

-(ScaleBehavior *)init:(short)scale {
    self = [super init];
    if(self) {
        self.scale = scale;
    }
    return self;
}

+(ScaleBehavior*) DISPLAY {
    return DISPLAY;
}

+(ScaleBehavior*) CALCULATE {
    return CALCULATE;
}
@end


@implementation Decimal

-(Decimal *)init:(NSDecimalNumber*)value {
    return [self init:value scale:DEFAULT_ROUND];
}

-(Decimal *)init:(NSDecimalNumber *)value scale:(short)scale {
    self = [super init];
    if(self) {
        self.value = value;
        self.scale = [ScaleBehavior get:scale];
    }
    return self;
}

-(Decimal*) initWithNumber:(Number *)value {
    self = [super init];
    if(self) {
        self.value = [[NSDecimalNumber alloc] initWithString:[value description]];
        self.scale = CALCULATE;
    }
    return self;
}

-(Decimal*) toDecimal {
    return self;
}

-(Number*) add:(Number*)input {
    if([input class]== [self class]) {
        Decimal* dinput = (Decimal*)input;
        return [[Decimal alloc] init:[self.value decimalNumberByAdding:dinput.value withBehavior:self.scale]];
    }
    return [NumberOperators add:self right:input];
}

-(Number*) sub:(Number*)input {
    if([input class]== [self class]) {
        Decimal* dinput = (Decimal*)input;
        return [[Decimal alloc] init:[self.value decimalNumberBySubtracting:dinput.value withBehavior:self.scale]];
    }
    return [NumberOperators sub:self right:input];
}

-(Number*) mul:(Number*)input {
    if([input class]== [self class]) {
        Decimal* dinput = (Decimal*)input;
        return [[Decimal alloc] init:[self.value decimalNumberByMultiplyingBy:dinput.value withBehavior:self.scale]];
    }
    return [NumberOperators mul:self right:input];
}

-(Number*) div:(Number*)input {
    if([input class]== [self class]) {
        Decimal* dinput = (Decimal*)input;
        return [[Decimal alloc] init:[self.value decimalNumberByDividingBy:dinput.value withBehavior:self.scale]];
    }
    return [NumberOperators div:self right:input];
}

+(Decimal*) constructDouble: (double) d {
    return [[Decimal alloc] init:[[NSDecimalNumber alloc] initWithDouble:d]];
}

+(Decimal*) constructFloat: (float) f {
    return [[Decimal alloc] init:[[NSDecimalNumber alloc] initWithFloat:f]];
}

-(NSString*) description {
    return [[self.value decimalNumberByRoundingAccordingToBehavior:[ScaleBehavior DISPLAY]] stringValue];
}

@end
