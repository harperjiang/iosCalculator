//
//  PolynomialFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/7/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PolynomialFunctionTest.h"
#import "PolynomialFunction.h"
#import "NumConstant.h"
#import "Integer.h"
#import "ArithmeticFunction.h"
#import "Variable.h"

@implementation PolynomialFunctionTest

-(void)testPolynomialDescription {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    
    [pf addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf addItem:[NumConstant construct:[Integer construct:5]] power:2];
    [pf addItem:[NumConstant construct:[Integer construct:-1]] power:3];
    [pf addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf addItem:[NumConstant construct:[Integer construct:1]] power:0];

    STAssertEqualObjects([pf description], @"x⁴-x³+5x²-7x+1", @"");
    
    [pf addItem:[NumConstant construct:[Integer construct:-1]] power:6];
    
    STAssertEqualObjects([pf description], @"-x⁶+x⁴-x³+5x²-7x+1", @"");
    
    
    pf = [[PolynomialFunction alloc] init];
    [pf addItem:[NumConstant construct:[Integer construct:-2]] power:0];
    
    STAssertEqualObjects([pf description], @"-2", @"");
    
    [pf addItem:[NumConstant construct:[Integer construct:1]] power:0];
    STAssertEqualObjects([pf description], @"-1", @"");
    
    [pf addItem:[NumConstant construct:[Integer construct:3]] power:0];
    STAssertEqualObjects([pf description], @"2", @"");
    
}

-(void)testAdd {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
    
    PolynomialFunction* pf2 = [[PolynomialFunction alloc] init];
    
    [pf2 addItem:[NumConstant construct:[Integer construct:2]] power:6];
    [pf2 addItem:[NumConstant construct:[Integer construct:7]] power:1];
    [pf2 addItem:[NumConstant construct:[Integer construct:5]] power:4];
    [pf2 addItem:[NumConstant construct:[Integer construct:-1]] power:2];
    [pf2 addItem:[NumConstant construct:[Integer construct:-9]] power:0];
    
    PolynomialFunction* pf = [pf1 add:pf2];
    
    STAssertEqualObjects([pf description], @"2x⁶+6x⁴-x³+4x²-8", @"");
}

-(void)testSub {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
    
    PolynomialFunction* pf2 = [[PolynomialFunction alloc] init];
    
    [pf2 addItem:[NumConstant construct:[Integer construct:2]] power:6];
    [pf2 addItem:[NumConstant construct:[Integer construct:7]] power:1];
    [pf2 addItem:[NumConstant construct:[Integer construct:5]] power:4];
    [pf2 addItem:[NumConstant construct:[Integer construct:-1]] power:2];
    [pf2 addItem:[NumConstant construct:[Integer construct:-9]] power:0];
    
    PolynomialFunction* pf = [pf1 sub:pf2];
    
    STAssertEqualObjects([pf description], @"-2x⁶-4x⁴-x³+6x²-14x+10", @"");
}

-(void)testMul {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
    
    PolynomialFunction* pf2 = [[PolynomialFunction alloc] init];
    
    [pf2 addItem:[NumConstant construct:[Integer construct:2]] power:6];
    [pf2 addItem:[NumConstant construct:[Integer construct:7]] power:1];
    [pf2 addItem:[NumConstant construct:[Integer construct:5]] power:4];
    [pf2 addItem:[NumConstant construct:[Integer construct:-1]] power:2];
    [pf2 addItem:[NumConstant construct:[Integer construct:-9]] power:0];
    
    PolynomialFunction* pf = [pf1 mul:pf2];
    
    STAssertEqualObjects([pf description], @"2x^10-2x⁹+15x⁸-19x⁷+26x⁶-27x⁵-16x⁴+51x³-95x²+70x-9", @"");
}

-(void) testDiv {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
    
    PolynomialFunction* pf2 = [[PolynomialFunction alloc] init];
    
    [pf2 addItem:[NumConstant construct:[Integer construct:1]] power:3];
    [pf2 addItem:[NumConstant construct:[Integer construct:7]] power:2];
    [pf2 addItem:[NumConstant construct:[Integer construct:5]] power:1];
    [pf2 addItem:[NumConstant construct:[Integer construct:-9]] power:0];
    
    PolynomialFunction* pf = [pf1 div:pf2];
    STAssertEqualObjects([pf description], @"x-2", @"");
    
    pf = [pf1 div:pf1];
    STAssertEqualObjects([pf description], @"1", @"");
}

-(void) testMod {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
    
    PolynomialFunction* pf2 = [[PolynomialFunction alloc] init];
    
    [pf2 addItem:[NumConstant construct:[Integer construct:1]] power:3];
    [pf2 addItem:[NumConstant construct:[Integer construct:7]] power:2];
    [pf2 addItem:[NumConstant construct:[Integer construct:5]] power:1];
    [pf2 addItem:[NumConstant construct:[Integer construct:-9]] power:0];
    
    PolynomialFunction* pf = [pf1 mod:pf2];
    STAssertEqualObjects([pf description], @"8x²+12x-17", @"");
    
    pf = [pf1 mod:pf1];
    STAssertEqualObjects([pf description], @"0", @"");
}

-(void)testToPolynomial {
    ArithmeticFunction* left = [[ArithmeticFunction alloc] init:[Variable x] opr:ADD right:[NumConstant construct:[Integer construct:5]]];
    ArithmeticFunction* right = [[ArithmeticFunction alloc] init:[Variable x] opr:SUB right:[NumConstant construct:[Integer construct:3]]];
    ArithmeticFunction* arith = [[ArithmeticFunction alloc] init:left opr:MUL right:right];
    
    PolynomialFunction* pf = [PolynomialFunction toPolynomial:arith];
    STAssertEqualObjects([pf description], @"x²+2x-15", @"");
}

-(void)testDifferentiate {
    PolynomialFunction* pf1 = [[PolynomialFunction alloc] init];
    
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:4];
    [pf1 addItem:[NumConstant construct:[Integer construct:5]] power:2];
    [pf1 addItem:[NumConstant construct:[Integer construct:-1]] power:3];
    [pf1 addItem:[NumConstant construct:[Integer construct:-7]] power:1];
    [pf1 addItem:[NumConstant construct:[Integer construct:1]] power:0];
   
    STAssertEqualObjects([[pf1 differentiate:[Variable x]] description], @"4x³-3x²+10x-7", @"");
}

@end
