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
    Data* mod = [a mod:b];
    
    XCTAssertTrue([add isKindOfClass:[Integer class]], @"");
    XCTAssertTrue([sub isKindOfClass:[Integer class]], @"");
    XCTAssertTrue([mul isKindOfClass:[Integer class]], @"");
    XCTAssertTrue([div isKindOfClass:[Fraction class]], @"");
    XCTAssertTrue([mod isKindOfClass:[Integer class]], @"");
}

@end
