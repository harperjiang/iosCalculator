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
#import "DiffFunction.h"
#import "ArithmeticFunction.h"
#import "BasicFunction.h"
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
    STAssertEqualObjects([result class], [DiffFunction class], @"");
}

-(void) testParseSinPi {
    NSString* input = @"sin(π/2)";
    Function* result = [FunctionParser parse:input];
    STAssertTrue([result isKindOfClass:[BasicFunction class]],@"");
    BasicFunction* bf = (BasicFunction*)result;
    STAssertTrue([bf.base isKindOfClass:[ArithmeticFunction class]],@"");
    ArithmeticFunction* af = (ArithmeticFunction*)bf.base;
    STAssertTrue(af.opr == DIV,@"");
    STAssertTrue(af.left == [SpecialConstant PI],@"");
}

@end
