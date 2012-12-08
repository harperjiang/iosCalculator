//
//  ArithmeticFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunctionTest.h"
#import "ArithmeticFunction.h"
#import "FunctionParser.h"
#import "Function.h"
#import "Integer.h"
#import "Variable.h"
#import "NumConstant.h"

@implementation ArithmeticFunctionTest

-(void)testPlusAddMinus {
    NSString* input = @"4+-4";
    Function* func = [FunctionParser parse:input];
    Function* result = [func evaluate];
    
    STAssertTrue([result isKindOfClass:[NumConstant class]],@"");
    STAssertEqualObjects(result, [NumConstant ZERO], @"");
}

-(void)testDescriptionWithParenthesis {
    ArithmeticFunction* arith = [[ArithmeticFunction alloc] init:[NumConstant construct:[Integer construct:5]] opr:ADD right:[NumConstant ONE]];
    ArithmeticFunction* outer = [[ArithmeticFunction alloc] init:arith opr:MUL right:[Variable x]];
    
    STAssertEqualObjects([outer description], @"(5+1)*x", @"");

    outer = [[ArithmeticFunction alloc] init:[Variable x] opr:MUL right:arith];
    STAssertEqualObjects([outer description], @"x*(5+1)", @"");
    
}

@end
