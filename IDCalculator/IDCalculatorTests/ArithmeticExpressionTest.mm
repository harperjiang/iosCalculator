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
#import "BasicFuncExpression.h"
#import "FunctionParser.h"
#import "Function.h"
#import "Integer.h"
#import "SpecialConstant.h"
#import "Variable.h"
#import "VariableContext.h"
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
    
    STAssertEqualObjects([outer description], @"(5+1)x", @"");

    outer = [[ArithmeticExpression alloc] init:[Variable x] opr:MUL right:arith];
    STAssertEqualObjects([outer description], @"x(5+1)", @"");
    
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

-(void) testCalculate {
    [[VariableContext instance] assign:@"x" value:[Integer construct:10]];
    Expression* left = [Variable x];
    Expression* right = [Integer construct:5];
    [[VariableContext instance] set:KEY_CALCULATE value:@"true"];
    ArithmeticExpression* add = [[ArithmeticExpression alloc] init:left opr:ADD right:right];
    STAssertEqualObjects([[add evaluate] description], @"15", @"");
    
    ArithmeticExpression* sub = [[ArithmeticExpression alloc] init:left opr:SUB right:right];
    STAssertEqualObjects([[sub evaluate] description], @"5", @"");
    
    ArithmeticExpression* mul = [[ArithmeticExpression alloc] init:left opr:MUL right:right];
    STAssertEqualObjects([[mul evaluate] description], @"50", @"");
    
    ArithmeticExpression* div = [[ArithmeticExpression alloc] init:left opr:DIV right:right];
    STAssertEqualObjects([[div evaluate] description], @"2", @"");
    
    [[VariableContext instance] assign:@"x" value:[Integer construct:4]];
    STAssertEqualObjects([[add evaluate] description], @"9", @"");
    STAssertEqualObjects([[sub evaluate] description], @"-1", @"");
    STAssertEqualObjects([[mul evaluate] description], @"20", @"");
    STAssertEqualObjects([[div evaluate] description], @"0.8", @"");
    
    [[VariableContext instance] remove:@"x"];
    [[VariableContext instance] set:KEY_CALCULATE value:nil];
}

-(void) testSimplify {
    ArithmeticExpression* l1 = [[ArithmeticExpression alloc] init:[Integer construct:5] opr:ADD right:[Variable x]];
    ArithmeticExpression* l2 = [[ArithmeticExpression alloc] init:[Integer construct:4] opr:SUB right:[Variable x]];
    ArithmeticExpression* main = [[ArithmeticExpression alloc] init:l1 opr:ADD right:l2];
    STAssertEqualObjects([[main evaluate] description], @"9", @"");
    
    // sin(x)-(-cos(x))
    l1 = [[ArithmeticExpression alloc] init:[[BasicFuncExpression alloc] init:BT_SIN base:[Variable x]] opr:SUB right:[[ArithmeticExpression alloc] init:nil opr:SUB right:[[BasicFuncExpression alloc] init:BT_COS base:[Variable x]]]];
    STAssertEqualObjects([[l1 evaluate] description], @"sin(x)+cos(x)", @"");
    // sinx*1*cos(x)
    l1 = [[ArithmeticExpression alloc] init:[[BasicFuncExpression alloc] init:BT_SIN base:[Variable x]] opr:MUL right:[[ArithmeticExpression alloc] init:[Integer ONE] opr:MUL right:[[BasicFuncExpression alloc] init:BT_COS base:[Variable x]]]];
    STAssertEqualObjects([[l1 evaluate] description], @"sin(x)cos(x)", @"");
    
    // sinx/1/cos(x)
    l1 = [[ArithmeticExpression alloc] init:[[BasicFuncExpression alloc] init:BT_SIN base:[Variable x]] opr:DIV right:[[ArithmeticExpression alloc] init:[Integer ONE] opr:DIV right:[[BasicFuncExpression alloc] init:BT_COS base:[Variable x]]]];
    STAssertEqualObjects([[l1 evaluate] description], @"sin(x)cos(x)", @"");
}

-(void) testArithConstant {
    ArithmeticExpression* ac = [[ArithmeticExpression alloc] init:[SpecialConstant PI] opr:DIV right:[Integer construct:2]];
    STAssertEqualObjects([[ac evaluate] description], @"π/2",@"");
}

@end
