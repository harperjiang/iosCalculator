//
//  IntegerTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/13/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "IntegerTest.h"
#import "Integer.h"
#import "Fraction.h"

@implementation IntegerTest

-(void) testArithmetic {
    Integer* a = [Integer construct:4];
    Integer* b = [Integer construct:6];
    
    Data* add = [a add:b];
    Data* sub = [a sub:b];
    Data* mul = [a mul:b];
    Data* div = [a div:b];
    
    STAssertTrue([add isKindOfClass:[Integer class]], @"");
    STAssertTrue([sub isKindOfClass:[Integer class]], @"");
    STAssertTrue([mul isKindOfClass:[Integer class]], @"");
    STAssertTrue([div isKindOfClass:[Fraction class]], @"");
}

@end
