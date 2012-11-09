//
//  FractionConstantTest.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FractionConstantTest.h"
#import "FractionConstant.h"
#import "IntegerConstant.h"

@implementation FractionConstantTest

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testConstruct {
    IntegerConstant* ZERO = [IntegerConstant ZERO];
    IntegerConstant* ONE = [IntegerConstant ONE];
    Constant* fc = [FractionConstant construct:[IntegerConstant construct:10] denominator:[IntegerConstant construct:5]];
    STAssertTrue([fc class] == [IntegerConstant class], @"Output is not an integer");
    
    IntegerConstant* ic = (IntegerConstant*)fc;
    STAssertEquals(2, [ic value], @"Output should be 2");
    
    fc = [FractionConstant construct:[IntegerConstant construct:0] denominator:[IntegerConstant construct:5]];
    STAssertTrue([fc class] == [IntegerConstant class], @"Output is not an integer");
    STAssertEqualObjects(ZERO, fc, @"Output should be 0");
    
    fc = [FractionConstant construct:[IntegerConstant construct:10] denominator:[IntegerConstant construct:10]];
    STAssertTrue([fc class] == [IntegerConstant class], @"Output is not an integer");
    STAssertEqualObjects(ONE, fc, @"Output should be 1");
    
    Constant* fc1 = [FractionConstant construct:[IntegerConstant construct:10] denominator:[IntegerConstant construct:3]];
    Constant* fc2 = [FractionConstant construct:[IntegerConstant construct:4] denominator:[IntegerConstant construct:5]];
    Constant* fc3 = [FractionConstant construct:[IntegerConstant construct:7] denominator:[IntegerConstant construct:9]];
    Constant* ic1 = [IntegerConstant construct:5];
    Constant* ic2 = [IntegerConstant construct:9];
    
    fc = [FractionConstant construct:fc1 denominator:ic1];
    STAssertTrue([fc class] == [FractionConstant class], @"Output is not an fraction");
    FractionConstant* fcresult = (FractionConstant*)fc;
    STAssertEquals(2, [(IntegerConstant*)[fcresult numerator] value], @"Numerator should be 2");
    STAssertEquals(3, [(IntegerConstant*)[fcresult denominator] value], @"Denominator should be 3");
    
    fc = [FractionConstant construct:ic2 denominator:fc2];
    STAssertTrue([fc class] == [FractionConstant class], @"Output is not an fraction");
    fcresult = (FractionConstant*)fc;
    STAssertEquals(45, [(IntegerConstant*)[fcresult numerator] value], @"Numerator should be 45");
    STAssertEquals(4, [(IntegerConstant*)[fcresult denominator] value], @"Denominator should be 4");
    
    fc = [FractionConstant construct:fc3 denominator:fc2];
    STAssertTrue([fc class] == [FractionConstant class], @"Output is not an fraction");
    fcresult = (FractionConstant*)fc;
    STAssertEquals(35, [(IntegerConstant*)[fcresult numerator] value], @"Numerator should be 35");
    STAssertEquals(36, [(IntegerConstant*)[fcresult denominator] value], @"Denominator should be 36");
}

@end
