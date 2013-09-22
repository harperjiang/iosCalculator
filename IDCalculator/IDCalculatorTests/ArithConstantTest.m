//
//  ArithConstantTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/21/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ArithConstantTest.h"
#import "ArithConstant.h"
#import "SpecialConstant.h"
#import "Integer.h"


@implementation ArithConstantTest

-(void) testEvaluate {
    ArithConstant* ac = [[ArithConstant alloc] init:[SpecialConstant PI] opr:DIV right:[Integer construct:2]];
    STAssertEqualObjects([[ac evaluate] description], @"π/2",@"");
}

@end
