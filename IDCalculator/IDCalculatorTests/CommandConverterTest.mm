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
#import "VariableCommand.h"
#import "Command.h"

@implementation CommandConverterTest

-(void) testParseClear {
    NSString* input = @"clear";
    Command* result = [CommandConverter parse:input];
    
    STAssertTrue([result class] == [ClearCommand class], @"");
}

-(void) testParseAssign {
    NSString* input = @"a = [5; 6]";
    Command* cmd = [CommandConverter parse:input];
}

-(void) testParseVar {
    NSString* input = @"p";
    Command* cmd = [CommandConverter parse:input];
    
    STAssertTrue([cmd class] == [VariableCommand class], @"");
    VariableCommand* varc = (VariableCommand*)cmd;
    STAssertEqualObjects(@"p", varc.name, @"");
}

@end
