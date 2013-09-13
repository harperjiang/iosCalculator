//
//  BasicFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFuncExpressionTest.h"
#import "BasicFuncExpression.h"
#import "Variable.h"

@implementation BasicFuncExpressionTest

-(void)testEvaluate {
    BasicFuncExpression* bf = [[BasicFuncExpression alloc] init:BT_SIN base:[Variable x]];
    Expression* eval = [bf evaluate];
    STAssertEqualObjects(eval,bf,@"");
    
    bf.type = BT_COS;
    eval = [bf evaluate];
    STAssertEqualObjects(eval, bf, @"");
    
    bf.type = BT_LN;
    eval = [bf evaluate];
    STAssertEqualObjects(eval, bf, @"");
}

@end
