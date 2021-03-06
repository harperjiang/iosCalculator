//
//  InteFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/17/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "InteExpressionTest.h"
#import "FunctionParser.h"

@implementation InteExpressionTest

-(void)testBasic {
    NSString* input = @"∫sin(x)dx";
    Function* func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description], @"-cos(x)", @"");
    
    input = @"∫cos(x)dx";
    func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description], @"sin(x)", @"");
    
    input = @"∫ln(x)dx";
    func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description], @"ln(x)x-x", @"");
}

-(void) testBasicArith {
    NSString* input = @"∫(sin(x)+cos(x))dx";
    Function* func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description],@"-cos(x)+sin(x)",@"");
    
    input = @"∫(sin(x)-cos(x))dx";
    func = [[FunctionParser parse:input ]evaluate];
    XCTAssertEqualObjects([func description],@"-cos(x)-sin(x)",@"");
    
    input = @"∫(cos(x)-sin(x))dx";
    func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description],@"sin(x)+cos(x)",@"");
    
    input = @"∫(x+1)*(x-1)dx";
    func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description],@"(1/3)x³-x",@"");
    
    input = @"∫(x^2+5x+1)/(4x-1)dx";
    func = [[FunctionParser parse:input] evaluate];
    XCTAssertEqualObjects([func description],@"(1/8)x²+(21/16)x+(37/64)ln(4x-1)",@"");
}

-(void)testPower {
    NSString* input = @"∫((x^2+5x+7)^2)dx";
    Function* func = [FunctionParser parse:input];
    func = [func evaluate];
    XCTAssertEqualObjects([func description],@"(1/5)x⁵+(5/2)x⁴+13x³+35x²+49x",@"");
}

@end
