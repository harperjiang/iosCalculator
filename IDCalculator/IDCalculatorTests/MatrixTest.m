//
//  MatrixTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//
#import "Matrix.h"
#import "IntegerConstant.h"
#import "MatrixTest.h"

@implementation MatrixTest

-(void) testDescription {
    NSMutableArray* dataB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataB insertObject:[IntegerConstant construct:i+5] atIndex:i];
    
    Matrix* matrixB = [[Matrix alloc] init:dataB m:2 n:5];
    NSString* result = [NSString stringWithFormat:@"%d\t%d\t%d\t%d\t%d\t\n%d\t%d\t%d\t%d\t%d\t\n",5,6,7,8,9,10,11,12,13,14];
    STAssertEqualObjects([matrixB description], result, @"");
}

@end
