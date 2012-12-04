//
//  BasicFunctionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "BasicFunctionTest.h"
#import "BasicFunction.h"
#import "Variable.h"

@implementation BasicFunctionTest

-(void)testEvaluate {
    BasicFunction* bf = [[BasicFunction alloc] init:BT_SIN base:[Variable x]];
    Function* eval = [bf evaluate];
    STAssertEqualObjects(eval,bf,@"");
    
    bf.type = BT_COS;
    eval = [bf evaluate];
    STAssertEqualObjects(eval, bf, @"");
    
    bf.type = BT_LN;
    eval = [bf evaluate];
    STAssertEqualObjects(eval, bf, @"");
}

@end
