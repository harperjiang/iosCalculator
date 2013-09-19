//
//  ConstantTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/18/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ConstantTest.h"
#import "Expression.h"
#import "SpecialConstant.h"
#import "ArithConstant.h"
#import "Integer.h"

@implementation ConstantTest


-(void) testOperationWithConstant {
    Expression* exp = [[Integer ZERO] sub:[SpecialConstant PI]];
    STAssertEqualObjects([exp class],[ArithConstant class], @"");
    STAssertEqualObjects([exp description],@"0-π",@"");
}

@end
