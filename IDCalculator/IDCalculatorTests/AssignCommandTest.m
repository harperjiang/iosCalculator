//
//  AssignCommandTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//
#import "IDCConsole.h"
#import "Integer.h"
#import "IDCConsoleTest.h"
#import "Matrix.h"
#import "AssignCommand.h"
#import "ArithmeticExpression.h"
#import "AssignCommandTest.h"
#import "VariableContext.h"

@implementation AssignCommandTest

-(void) testAssign {
    NSMutableArray* dataA = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataA insertObject:[Integer construct:i] atIndex:i];
    
    Matrix* matrixA = [[Matrix alloc] init:dataA m:5 n:2];
    
    NSMutableArray* dataB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataB insertObject:[Integer construct:i+5] atIndex:i];
    
    Matrix* matrixB = [[Matrix alloc] init:dataB m:2 n:5];
    
    ArithmeticExpression* exp = [[ArithmeticExpression alloc] init:matrixA opr:MUL right:matrixB];
    
    
    AssignCommand* assign = [[AssignCommand alloc] init:@"p" value:exp];
    
    [assign execute];
    Matrix* result = (Matrix*)[[VariableContext instance] lookup:@"p"];
    
    XCTAssertEqualObjects([[result val:0 n:0] description], @"10", @"");
    XCTAssertEqualObjects([[result val:0 n:1] description], @"11", @"");
    XCTAssertEqualObjects([[result val:0 n:2] description], @"12", @"");
    XCTAssertEqualObjects([[result val:0 n:3] description], @"13", @"");
    XCTAssertEqualObjects([[result val:0 n:4] description], @"14", @"");
    XCTAssertEqualObjects([[result val:1 n:0] description], @"40", @"");
    XCTAssertEqualObjects([[result val:1 n:1] description], @"45", @"");
    XCTAssertEqualObjects([[result val:1 n:2] description], @"50", @"");
    XCTAssertEqualObjects([[result val:1 n:3] description], @"55", @"");
    XCTAssertEqualObjects([[result val:1 n:4] description], @"60", @"");
    XCTAssertEqualObjects([[result val:2 n:0] description], @"70", @"");
    XCTAssertEqualObjects([[result val:2 n:1] description], @"79", @"");
    XCTAssertEqualObjects([[result val:2 n:2] description], @"88", @"");
    XCTAssertEqualObjects([[result val:2 n:3] description], @"97", @"");
    XCTAssertEqualObjects([[result val:2 n:4] description], @"106", @"");

}

@end
