//
//  PolynomialExpressionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/7/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PolynomialExpressionTest.h"
#import "PolynomialExpression.h"
#import "Integer.h"
#import "ArithmeticExpression.h"
#import "Variable.h"
#import "VariableContext.h"

@implementation PolynomialExpressionTest

-(void)testPolynomialDescription {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    
    [pf addItem:[Integer construct:1] power:4];
    [pf addItem:[Integer construct:5] power:2];
    [pf addItem:[Integer construct:-1] power:3];
    [pf addItem:[Integer construct:-7] power:1];
    [pf addItem:[Integer construct:1] power:0];

    STAssertEqualObjects([pf description], @"x⁴-x³+5x²-7x+1", @"");
    
    [pf addItem:[Integer construct:-1] power:6];
    
    STAssertEqualObjects([pf description], @"-x⁶+x⁴-x³+5x²-7x+1", @"");
    
    
    pf = [[PolynomialExpression alloc] init];
    [pf addItem:[Integer construct:-2] power:0];
    
    STAssertEqualObjects([pf description], @"-2", @"");
    
    [pf addItem:[Integer construct:1] power:0];
    STAssertEqualObjects([pf description], @"-1", @"");
    
    [pf addItem:[Integer construct:3] power:0];
    STAssertEqualObjects([pf description], @"2", @"");
    
}

-(void)testAdd {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:2];
    [pf1 addItem:[Integer construct:-1] power:3];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
    
    PolynomialExpression* pf2 = [[PolynomialExpression alloc] init];
    
    [pf2 addItem:[Integer construct:2] power:6];
    [pf2 addItem:[Integer construct:7] power:1];
    [pf2 addItem:[Integer construct:5] power:4];
    [pf2 addItem:[Integer construct:-1] power:2];
    [pf2 addItem:[Integer construct:-9] power:0];
    
    PolynomialExpression* pf = [pf1 add:pf2];
    
    STAssertEqualObjects([pf description], @"2x⁶+6x⁴-x³+4x²-8", @"");
}

-(void)testSub {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:2];
    [pf1 addItem:[Integer construct:-1] power:3];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
    
    PolynomialExpression* pf2 = [[PolynomialExpression alloc] init];
    
    [pf2 addItem:[Integer construct:2] power:6];
    [pf2 addItem:[Integer construct:7] power:1];
    [pf2 addItem:[Integer construct:5] power:4];
    [pf2 addItem:[Integer construct:-1] power:2];
    [pf2 addItem:[Integer construct:-9] power:0];
    
    PolynomialExpression* pf = [pf1 sub:pf2];
    
    STAssertEqualObjects([pf description], @"-2x⁶-4x⁴-x³+6x²-14x+10", @"");
}

-(void)testMul {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:2];
    [pf1 addItem:[Integer construct:-1] power:3];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
    
    PolynomialExpression* pf2 = [[PolynomialExpression alloc] init];
    
    [pf2 addItem:[Integer construct:2] power:6];
    [pf2 addItem:[Integer construct:7] power:1];
    [pf2 addItem:[Integer construct:5] power:4];
    [pf2 addItem:[Integer construct:-1] power:2];
    [pf2 addItem:[Integer construct:-9] power:0];
    
    PolynomialExpression* pf = [pf1 mul:pf2];
    
    STAssertEqualObjects([pf description], @"2x^10-2x⁹+15x⁸-19x⁷+26x⁶-27x⁵-16x⁴+51x³-95x²+70x-9", @"");
}

-(void) testDiv {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:3];
    [pf1 addItem:[Integer construct:-1] power:2];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
    
    PolynomialExpression* pf2 = [[PolynomialExpression alloc] init];
    
    [pf2 addItem:[Integer construct:1] power:3];
    [pf2 addItem:[Integer construct:7] power:2];
    [pf2 addItem:[Integer construct:5] power:1];
    [pf2 addItem:[Integer construct:-9] power:0];
    
    PolynomialExpression* pf = [pf1 div:pf2];
    STAssertEqualObjects([pf description], @"x-2", @"");
    
    pf = [pf1 div:pf1];
    STAssertEqualObjects([pf description], @"1", @"");
}

-(void) testMod {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:3];
    [pf1 addItem:[Integer construct:-1] power:2];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
    
    PolynomialExpression* pf2 = [[PolynomialExpression alloc] init];
    
    [pf2 addItem:[Integer construct:1] power:3];
    [pf2 addItem:[Integer construct:7] power:2];
    [pf2 addItem:[Integer construct:5] power:1];
    [pf2 addItem:[Integer construct:-9] power:0];
    
    PolynomialExpression* pf = [pf1 mod:pf2];
    STAssertEqualObjects([pf description], @"8x²+12x-17", @"");
    
    pf = [pf1 mod:pf1];
    STAssertEqualObjects([pf description], @"0", @"");
}

-(void)testToPolynomial {
    ArithmeticExpression* left = [[ArithmeticExpression alloc] init:[Variable x] opr:ADD right:[Integer construct:5]] ;
    ArithmeticExpression* right = [[ArithmeticExpression alloc] init:[Variable x] opr:SUB right:[Integer construct:3]] ;
    ArithmeticExpression* arith = [[ArithmeticExpression alloc] init:left opr:MUL right:right];
    
    PolynomialExpression* pf = [PolynomialExpression toPolynomial:arith];
    STAssertEqualObjects([pf description], @"x²+2x-15", @"");
}

-(void)testDifferentiate {
    PolynomialExpression* pf1 = [[PolynomialExpression alloc] init];
    
    [pf1 addItem:[Integer construct:1] power:4];
    [pf1 addItem:[Integer construct:5] power:2];
    [pf1 addItem:[Integer construct:-1] power:3];
    [pf1 addItem:[Integer construct:-7] power:1];
    [pf1 addItem:[Integer construct:1] power:0];
   
    STAssertEqualObjects([[pf1 differentiate:[Variable x]] description], @"4x³-3x²+10x-7", @"");
}

-(void) testCalculate {
    PolynomialExpression* pe = [[PolynomialExpression alloc] init];
    [pe addItem:[Integer construct:3] power:2];
    
    [[VariableContext instance] assign:@"x" value:[Integer construct:3]];
    
    STAssertEqualObjects([[pe evaluate] description], @"27",@"");
    
    [[VariableContext instance] remove:@"x"];
}

@end
