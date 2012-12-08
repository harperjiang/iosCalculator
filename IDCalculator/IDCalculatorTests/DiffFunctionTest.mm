//
//  DiffFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/3/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DiffFunctionTest.h"
#import "DiffFunction.h"
#import "BasicFunction.h"
#import "Variable.h"
#import "FunctionParser.h"

@implementation DiffFunctionTest

-(void)testDifferentiate {
    DiffFunction* diff = [[DiffFunction alloc] init];
    BasicFunction* basic = [[BasicFunction alloc] init:BT_SIN base:[Variable x]];
    diff.variable = [Variable x];
    diff.base = basic;
    
    Function* result = [diff evaluate];
    STAssertEqualObjects([result description], @"cos(x)", @"");
}

-(void)testPolynomialDiff {
    Function* func = [FunctionParser parse:@"d(8x^3 + 7x^2 + 3x + 7)/dx"];
    Function* diff = [func evaluate];
    STAssertEqualObjects([diff description], @"24x²+14x+3", @"");
}

-(void) testBasicFunc {
    Function* func = [FunctionParser parse:@"dcos(x)/dx"];
    Function* diff = [func evaluate];
    STAssertEqualObjects([diff description], @"-sin(x)", @"");

}

-(void) testNegativePower {
    Function* func = [FunctionParser parse:@"d(1/x)/dx"];
    Function* diff = [func evaluate];
    STAssertEqualObjects([diff description], @"-1/x²", @"");
    
}

-(void)testComplexPolynomial {
    Function* func = [FunctionParser parse:@"d((x^2+1)/(x+1))/dx"];
    Function* diff = [func evaluate];
    STAssertEqualObjects([diff description], @"(x²+2x-1)/(x²+2x+1)", @"");
}

@end
