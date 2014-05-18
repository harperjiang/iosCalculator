//
//  BasicFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFuncExpressionTest.h"
#import "BasicFuncExpression.h"
#import "ArithmeticExpression.h"
#import "SpecialConstant.h"
#import "Integer.h"
#import "Variable.h"

@implementation BasicFuncExpressionTest

-(void)testEvaluate {
    BasicFuncExpression* bf = [[BasicFuncExpression alloc] init:BT_SIN base:[Variable x]];
    Expression* eval = [bf evaluate];
    XCTAssertEqualObjects(eval,bf,@"");
    
    bf.type = BT_COS;
    eval = [bf evaluate];
    XCTAssertEqualObjects(eval, bf, @"");
    
    bf.type = BT_LN;
    eval = [bf evaluate];
    XCTAssertEqualObjects(eval, bf, @"");
    
    BasicFuncExpression* fraction = [[BasicFuncExpression alloc] init:BT_SIN base:[[ArithmeticExpression alloc] init:[SpecialConstant PI] opr:DIV right:[Integer construct:2]]];
    eval = [fraction evaluate];
    XCTAssertEqualObjects([eval description], @"sin(π/2)", @"");
}


@end
