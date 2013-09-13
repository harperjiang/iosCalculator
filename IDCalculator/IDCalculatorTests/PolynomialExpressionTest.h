//
//  PolynomialFunctionTest.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/7/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface PolynomialExpressionTest : SenTestCase

-(void) testPolynomialDescription;
-(void) testAdd;
-(void) testSub;
-(void) testMul;
-(void) testDiv;
-(void) testMod;
-(void) testToPolynomial;
-(void) testDifferentiate;
@end