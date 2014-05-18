//
//  DiffFunction.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/3/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DiffExpressionTest : XCTestCase

-(void) testDifferentiate;
-(void) testPolynomialDiff;
-(void) testBasicFunc;
-(void) testNegativePower;
-(void) testComplexPolynomial;
@end
