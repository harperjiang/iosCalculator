//
//  CommandConverter.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CommandConverter.h"
#import "Expression.h"
#import "ClearCommand.h"
#import "VariableCommand.h"
#import "AssignCommand.h"
#import "ConsoleLexer.h"
#import "ConsoleParser.h"
#import "Matrix.h"

extern int yyparse();
extern CCommand* parse_result;

@implementation CommandConverter {
    CCommand* parse;
}

-(void) innerParse:(NSString*)input {
    YY_BUFFER_STATE bufferState = yy_scan_string([input UTF8String]);
    if(!yyparse()) {
        self->parse = parse_result;
    }
    yy_delete_buffer(bufferState);
    return;
}

-(Command*) convert {
    Command* command = nil;
    if(self->parse != nil) {
        if(self->parse->type() == CLEAR_COMMAND) {
            command = [[ClearCommand alloc] init];
        }
        if(self->parse->type() == VAR_COMMAND) {
            CVarCommand* cvar = (CVarCommand*)self->parse;
            NSString* varname = [NSString stringWithUTF8String:cvar->id->name];
            VariableCommand* vcmd = [[VariableCommand alloc] init:varname];
            command = vcmd;
        }
        if(self->parse->type() == ASSIGN_COMMAND) {
            CAssignCommand* cass = (CAssignCommand*)self->parse;
            AssignCommand* ass = [[AssignCommand alloc] init:translate(cass->id->name) value:translate(cass->value)];
            command = ass;
        }
        delete self->parse;
    }
    return command;
}

+(Command*) parse:(NSString*) input {
    CommandConverter* cc = [[CommandConverter alloc] init];
    [cc innerParse:input];
    return [cc convert];
}
                                  
NSString* translate(char* input) {
    return [NSString stringWithUTF8String:input];
}

Expression* translate(CExpression* input) {
    return nil;
}
@end
