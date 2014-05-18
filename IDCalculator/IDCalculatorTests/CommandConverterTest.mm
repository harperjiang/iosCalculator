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
#import "PlotFuncCommand.h"
#import "Command.h"
#import "Variable.h"
#import "ArithmeticExpression.h"
#import "FuncExpression.h"
#import "Matrix.h"
#import "Number.h"
#import "Integer.h"
#import "Decimal.h"

@implementation CommandConverterTest

-(void) testParseClear {
    NSString* input = @"clear";
    Command* result = [CommandConverter parse:input];
    
    XCTAssertTrue([result class] == [ClearCommand class], @"");
}

-(void) testParseAssign {
    NSString* input = @"a = [5 8;4 6]";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [AssignCommand class],@"");
    AssignCommand* ascmd = (AssignCommand*)cmd;
    
    XCTAssertEqualObjects([ascmd name], @"a", @"");
    XCTAssertTrue([[ascmd exp] class] == [Matrix class],@"");
    Matrix* matrix = (Matrix*)[ascmd exp];
    XCTAssertEqualObjects([[matrix val:0 n:0] description],@"5",@"");
    XCTAssertEqualObjects([[matrix val:0 n:1] description],@"8",@"");
    XCTAssertEqualObjects([[matrix val:1 n:0] description],@"4",@"");
    XCTAssertEqualObjects([[matrix val:1 n:1] description],@"6",@"");
}

-(void) testParseAssignWrongMatrix {
    NSString* input = @"a = [5 8;4 6 7]";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertEqualObjects(cmd,nil,@"");
}

-(void) testParseExpId {
    NSString* input = @"p";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [ExpressionCommand class], @"");
    ExpressionCommand* varc = (ExpressionCommand*)cmd;
    XCTAssertEqualObjects([Variable class], [varc.expression class], @"");
    Variable* cid = (Variable*)varc.expression;
    XCTAssertEqualObjects(@"p",cid.name,@"");
}

-(void) testParseArith {
    NSString* input = @"a*b";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    XCTAssertEqualObjects([ArithmeticExpression class], [expcmd.expression class], @"");
    
    ArithmeticExpression* arith = (ArithmeticExpression*)[expcmd expression];
    
    XCTAssertEqualObjects([[arith left] class],[Variable class],@"");
    XCTAssertEqualObjects([[arith right] class],[Variable class],@"");
}

-(void) testParseSingleQuote {
    NSString* input = @"[5 3]'";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    XCTAssertEqualObjects([FuncExpression class], [expcmd.expression class], @"");
    
    FuncExpression* func = (FuncExpression*)[expcmd expression];
    XCTAssertEqualObjects([[func name] name],@"transpose",@"");
}

-(void) testParsingFunction {
    NSString* input = @"inverse(a)";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    XCTAssertEqualObjects([FuncExpression class], [expcmd.expression class], @"");
    
    FuncExpression* func = (FuncExpression*)[expcmd expression];
    XCTAssertEqualObjects([[func name] name],@"inverse",@"");
}

-(void) testParseDecimal {
    NSString* input = @"3.8583234+6.7";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [ExpressionCommand class], @"");
    
    ExpressionCommand* expcmd = (ExpressionCommand*)cmd;
    XCTAssertEqualObjects([ArithmeticExpression class], [expcmd.expression class], @"");
    
    ArithmeticExpression* arith = (ArithmeticExpression*)[expcmd expression];
    XCTAssertEqualObjects([arith.left class], [Decimal class],@"");
    XCTAssertEqualObjects([arith.right class], [Decimal class],@"");
    
    XCTAssertEqualObjects([arith.left description], @"3.8583", @"");
    XCTAssertEqualObjects([arith.right description], @"6.7", @"");
}

-(void) testParsePlot {
    NSString* input = @"plot x+4 as a";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertTrue([cmd class] == [PlotFuncCommand class], @"");
    PlotFuncCommand* pfc = (PlotFuncCommand*)cmd;
    XCTAssertEqualObjects([pfc.function.expression class], [ArithmeticExpression class], @"");
    
    ArithmeticExpression* arith = (ArithmeticExpression*) pfc.function.expression;
    
    XCTAssertEqualObjects([arith.left class], [Variable class], @"");
    XCTAssertEqualObjects([arith.right class], [Integer class], @"");
    
}

-(void) testParseRemove {
    NSString* input1 = @"plot remove x";
    Command* cmd = [CommandConverter parse:input1];
    
    XCTAssertTrue([cmd class] == [PlotRemoveCommand class], @"");
    PlotRemoveCommand* prc = (PlotRemoveCommand*) cmd;
    XCTAssertEqualObjects(prc.identifier, @"x",@"");
    
    NSString* input2 = @"plot remove all";
    cmd = [CommandConverter parse:input2];
    
    XCTAssertTrue([cmd class] == [PlotRemoveCommand class], @"");
    XCTAssertEqualObjects([(PlotRemoveCommand*)cmd identifier], nil, @"");
}

-(void) testParseExp {
    NSString* input = @"plot (3*x+5)^(1/2) as t";
    Command* cmd = [CommandConverter parse:input];
    
    XCTAssertEqualObjects([cmd class], [PlotFuncCommand class], @"");
    PlotFuncCommand* pfc = (PlotFuncCommand*)cmd;
    XCTAssertTrue(pfc.function.expression!= nil, @"");
}

@end
