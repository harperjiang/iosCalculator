//
//  AssignCommandTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//
#import "IDCConsole.h"
#import "IntegerConstant.h"
#import "IDCConsoleTest.h"
#import "Matrix.h"
#import "AssignCommand.h"
#import "ArithmeticExpression.h"
#import "AssignCommandTest.h"

@implementation AssignCommandTest

-(void) testAssign {
    IDCConsole* console = [IDCConsole instance];
    
    
    NSMutableArray* dataA = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataA insertObject:[IntegerConstant construct:i] atIndex:i];
    
    Matrix* matrixA = [[Matrix alloc] init:dataA m:5 n:2];
    
    NSMutableArray* dataB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i++)
        [dataB insertObject:[IntegerConstant construct:i+5] atIndex:i];
    
    Matrix* matrixB = [[Matrix alloc] init:dataB m:2 n:5];
    
    ArithmeticExpression* exp = [[ArithmeticExpression alloc] init:matrixA operator:MUL right:matrixB];
    
    
    AssignCommand* assign = [[AssignCommand alloc] init:@"p" value:exp];
    
    [assign execute];
    Matrix* result = (Matrix*)[console get:@"p"];
    
    STAssertEqualObjects([[result val:0 n:0] description], @"10", @"");
    STAssertEqualObjects([[result val:0 n:1] description], @"11", @"");
    STAssertEqualObjects([[result val:0 n:2] description], @"12", @"");
    STAssertEqualObjects([[result val:0 n:3] description], @"13", @"");
    STAssertEqualObjects([[result val:0 n:4] description], @"14", @"");
    STAssertEqualObjects([[result val:1 n:0] description], @"40", @"");
    STAssertEqualObjects([[result val:1 n:1] description], @"45", @"");
    STAssertEqualObjects([[result val:1 n:2] description], @"50", @"");
    STAssertEqualObjects([[result val:1 n:3] description], @"55", @"");
    STAssertEqualObjects([[result val:1 n:4] description], @"60", @"");
    STAssertEqualObjects([[result val:2 n:0] description], @"70", @"");
    STAssertEqualObjects([[result val:2 n:1] description], @"79", @"");
    STAssertEqualObjects([[result val:2 n:2] description], @"88", @"");
    STAssertEqualObjects([[result val:2 n:3] description], @"97", @"");
    STAssertEqualObjects([[result val:2 n:4] description], @"106", @"");

}

@end
