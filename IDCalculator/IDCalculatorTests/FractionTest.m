//
//  FractionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/28/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FractionTest.h"
#import "Fraction.h"
#import "Integer.h"

@implementation FractionTest

-(void)testNegative {
    Number* number = [Fraction construct:[Integer ONE] denominator:[Integer construct:-7]];
    Number* num = (Number*)[[Integer ONE] mul:number];
    STAssertEqualObjects([num description], @"-1/7", @"");
}

@end
