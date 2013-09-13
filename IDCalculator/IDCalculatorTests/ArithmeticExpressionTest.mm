//
//  ArithmeticFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticExpressionTest.h"
#import "ArithmeticExpression.h"
#import "PolynomialExpression.h"
#import "FunctionParser.h"
#import "Function.h"
#import "Integer.h"
#import "Variable.h"
#import "Number.h"
#import "Matrix.h"

@implementation ArithmeticExpressionTest

-(void)testPlusAddMinus {
    ArithmeticExpression* ame = [[ArithmeticExpression alloc] init:[Integer construct:4] opr:ADD right:[Integer construct :-4]];
    
    STAssertEqualObjects([ame evaluate], [Integer ZERO], @"");
}

-(void)testDescriptionWithParenthesis {
    ArithmeticExpression* arith = [[ArithmeticExpression alloc] init:[Integer construct:5] opr:ADD right:[Integer ONE]];
    ArithmeticExpression* outer = [[ArithmeticExpression alloc] init:arith opr:MUL right: [Variable x]];
    
    STAssertEqualObjects([outer description], @"(5+1)*x", @"");

    outer = [[ArithmeticExpression alloc] init:[Variable x] opr:MUL right:arith];
    STAssertEqualObjects([outer description], @"x*(5+1)", @"");
    
    arith = [[ArithmeticExpression alloc] init:[Integer construct:5] opr:SUB right:[Integer ONE]];
    outer = [[ArithmeticExpression alloc] init:[Integer construct:3] opr:SUB right:arith];
    STAssertEqualObjects([outer description],@"3-(5-1)",@"");
}

-(void) testPolyMultiply {
    PolynomialExpression* first = [[PolynomialExpression alloc] init];
    [first addItem:[Integer ONE] power:1];
    [first addItem:[Integer construct:5] power:0];
    PolynomialExpression* second = [[PolynomialExpression alloc] init];
    [second addItem:[Integer ONE] power:1];
    [second addItem:[Integer construct:-8] power:0];
    Expression* result = [[[ArithmeticExpression alloc] init:first opr:MUL right:second] evaluate];
    
    STAssertTrue([result isKindOfClass:[PolynomialExpression class]],@"");
    STAssertEqualObjects([result description], @"x²-3x-40", @"");
}

-(void) testAddConstant {
    
}


-(void) testMatrixMul {
    NSMutableArray* dataA = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataA insertObject:[Integer construct:i] atIndex:i];
    
    Matrix* matrixA = [[Matrix alloc] init:dataA m:5 n:2];
    
    NSMutableArray* dataB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataB insertObject:[Integer construct:i+5] atIndex:i];
    
    Matrix* matrixB = [[Matrix alloc] init:dataB m:2 n:5];
    
    ArithmeticExpression* exp = [[ArithmeticExpression alloc] init:matrixA opr:MUL right:matrixB];
    
    Matrix* result = (Matrix*)[exp evaluate];
    
    STAssertEqualObjects([[result val:0 n:0] description], @"10", @"");
    STAssertEqualObjects([[result val:0 n:1] description], @"11", @"");
    STAssertEqualObjects([[result val:0 n:2] description], @"12", @"");
    STAssertEqualObjects([[result val:0 n:3] description], @"13", @"");
    STAssertEqualObjects([[result val:0 n:4] description], @"14", @"");
    STAssertEqualObjects([[result val:1 n:0] description], @"40", @"");
    STAssertEqualObjects([[result val:1 n:1] description], @"45", @"");
    STAssertEqualObjects([[result val:1 n:2] description], @"50", @"");
    STAssertEqualObjects([[result val:1 n:3] description], @"55", @"");
    STAssertEqualObjects([[result val:1 n:4] description], @"60", @"");
    STAssertEqualObjects([[result val:2 n:0] description], @"70", @"");
    STAssertEqualObjects([[result val:2 n:1] description], @"79", @"");
    STAssertEqualObjects([[result val:2 n:2] description], @"88", @"");
    STAssertEqualObjects([[result val:2 n:3] description], @"97", @"");
    STAssertEqualObjects([[result val:2 n:4] description], @"106", @"");
}

@end
