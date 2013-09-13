//
//  FunctionParserTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FunctionParserTest.h"
#import "FunctionParser.h"
#import "Function.h"
#import "DiffExpression.h"
#import "ArithmeticExpression.h"
#import "BasicFuncExpression.h"
#import "SpecialConstant.h"

@implementation FunctionParserTest

-(void) testParseSimple {
    NSString* input = @"sin(4π)";
    Function* result = [FunctionParser parse:input];
    STAssertTrue(result!=nil, @"");
}

-(void) testParseDiffSin {
    NSString* input = @"dsin(x)/dx";
    Function* result = [FunctionParser parse:input];
    STAssertEqualObjects([[result expression ]class], [DiffExpression class], @"");
}

-(void) testParseSinPi {
    NSString* input = @"sin(π/2)";
    Function* result = [FunctionParser parse:input];
    STAssertTrue([[result expression ]isKindOfClass:[BasicFuncExpression class]],@"");
    BasicFuncExpression* bf = (BasicFuncExpression*)[result expression];
    STAssertTrue([bf.base isKindOfClass:[ArithmeticExpression class]],@"");
    ArithmeticExpression* af = (ArithmeticExpression*)bf.base;
    STAssertTrue(af.opr == DIV,@"");
    STAssertTrue(af.left == [SpecialConstant PI],@"");
}

@end
