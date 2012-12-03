//
//  CommandConverterTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CommandConverterTest.h"
#import "CommandConverter.h"
#import "ClearCommand.h"
#import "ExpressionCommand.h"
#import "AssignCommand.h"
#import "Command.h"
#import "ConsoleIdentifier.h"
#import "ArithmeticExpression.h"
#import "FuncExpression.h"
#import "Matrix.h"
#import "NumberData.h"

@implementation CommandConverterTest

-(void) testParseClear {
    NSString* input = @"clear";
    Command* result = [CommandConverter parse:input];
    
    STAssertTrue([result class] == [ClearCommand class], @"");
}

-(void) testParseAssign {
    NSString* input = @"a = [5 8;4 6]";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [AssignCommand class],@"");
    AssignCommand* ascmd = (AssignCommand*)cmd;
    
    STAssertEqualObjects([ascmd name], @"a", @"");
    STAssertTrue([[ascmd exp] class] == [Matrix class],@"");
    Matrix* matrix = (Matrix*)[ascmd exp];
    STAssertEqualObjects([[matrix val:0 n:0] description],@"5",@"");
    STAssertEqualObjects([[matrix val:0 n:1] description],@"8",@"");
    STAssertEqualObjects([[matrix val:1 n:0] description],@"4",@"");
    STAssertEqualObjects([[matrix val:1 n:1] description],@"6",@"");
}

-(void) testParseAssignWrongMatrix {
    NSString* input = @"a = [5 8;4 6 7]";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertEqualObjects(cmd,nil,@"");
}

-(void) testParseExpId {
    NSString* input = @"p";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [ExpressionCommand class], @"");
    ExpressionCommand* varc = (ExpressionCommand*)cmd;
    STAssertEqualObjects([ConsoleIdentifier class], [varc.expression class], @"");
    ConsoleIdentifier* cid = (ConsoleIdentifier*)varc.expression;
    STAssertEqualObjects(@"p",cid.name,@"");
}

-(void) testParseArith {
    NSString* input = @"a*b";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    STAssertEqualObjects([ArithmeticExpression class], [expcmd.expression class], @"");
    
    ArithmeticExpression* arith = (ArithmeticExpression*)[expcmd expression];
    
    STAssertEqualObjects([[arith left] class],[ConsoleIdentifier class],@"");
    STAssertEqualObjects([[arith right] class],[ConsoleIdentifier class],@"");
}

-(void) testParseSingleQuote {
    NSString* input = @"[5 3]'";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    STAssertEqualObjects([FuncExpression class], [expcmd.expression class], @"");
    
    FuncExpression* func = (FuncExpression*)[expcmd expression];
    STAssertEqualObjects([[func name] name],@"transpose",@"");
}

-(void) testParsingFunction {
    NSString* input = @"inverse(a)";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    STAssertEqualObjects([FuncExpression class], [expcmd.expression class], @"");
    
    FuncExpression* func = (FuncExpression*)[expcmd expression];
    STAssertEqualObjects([[func name] name],@"inverse",@"");
}

-(void) testParseDecimal {
    NSString* input = @"3.8583234+6.7";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    STAssertEqualObjects([ArithmeticExpression class], [expcmd.expression class], @"");
    
    ArithmeticExpression* arith = (ArithmeticExpression*)[expcmd expression];
    STAssertEqualObjects([arith.left class], [NumberData class],@"");
    STAssertEqualObjects([arith.right class], [NumberData class],@"");
    
    STAssertEqualObjects([arith.left description], @"3.8583", @"");
    STAssertEqualObjects([arith.right description], @"6.7", @"");
}

@end
