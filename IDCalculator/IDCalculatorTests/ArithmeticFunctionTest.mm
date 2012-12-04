//
//  ArithmeticFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunctionTest.h"
#import "FunctionParser.h"
#import "Function.h"
#import "NumConstant.h"

@implementation ArithmeticFunctionTest

-(void)testPlusAddMinus {
    NSString* input = @"4+-4";
    Function* func = [FunctionParser parse:input];
    Function* result = [func evaluate];
    
    STAssertTrue([result isKindOfClass:[NumConstant class]],@"");
    STAssertEqualObjects(result, [NumConstant ZERO], @"");
}

@end
