//
//  MatrixTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//
#import "Matrix.h"
#import "Integer.h"
#import "MatrixTest.h"

@implementation MatrixTest

-(void) testDescription {
    NSMutableArray* dataB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataB insertObject:[Integer construct:i+5] atIndex:i];
    
    Matrix* matrixB = [[Matrix alloc] init:dataB m:2 n:5];
    NSString* result = [NSString stringWithFormat:@"%d\t%d\t%d\t%d\t%d\t\n%d\t%d\t%d\t%d\t%d\t\n",5,6,7,8,9,10,11,12,13,14];
    XCTAssertEqualObjects([matrixB description], result, @"");
}

-(void) testInverse {
    ExpressionList* empty = [[ExpressionList alloc] init];
    
    Matrix* m = [[Matrix alloc] initWithExpression:empty];
    
    for(int i = 1 ; i < 10 ; i++) {
       [m setVal:(i-1)/3 n:(i-1)%3 val:[Integer construct:i]];
    }
    [m setVal:2 n:2 val:[Integer construct:10]];
    
    Matrix* inv = [m inverse];
    NSString* result = [NSString stringWithFormat:@"%d\t%d\t%d\t\n%d\t%d\t%d\t\n%d\t%d\t%d\t\n",1,0,0,0,1,0,0,0,1];

    XCTAssertEqualObjects([[inv mul:m] description],result,@"");
    
    empty = [[ExpressionList alloc] init];
    m = [[Matrix alloc] initWithExpression:empty];
    [m setVal:0 n:0 val: [Integer construct:1]];
    [m setVal:0 n:1 val: [Integer construct:4]];
    [m setVal:1 n:0 val: [Integer construct:3]];
    [m setVal:1 n:1 val: [Integer construct:5]];
    inv = [m inverse];
    result = [NSString stringWithFormat:@"%d\t%d\t\n%d\t%d\t\n",1,0,0,1];
    XCTAssertEqualObjects([[inv mul:m] description], result, @"");
}

@end
