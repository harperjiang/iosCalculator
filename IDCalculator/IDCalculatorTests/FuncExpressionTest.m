//
//  FuncExpressionTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/26/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FuncExpression.h"

@interface FuncExpressionTest : SenTestCase

@end

@implementation FuncExpressionTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testCRT
{
    CRTFuncCallback* callback = [[CRTFuncCallback alloc] init];
}

@end
