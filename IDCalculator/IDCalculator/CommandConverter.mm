//
//  CommandConverter.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CommandConverter.h"
#import "Expression.h"
#import "ExpressionList.h"
#import "ArithmeticExpression.h"
#import "FuncExpression.h"
#import "PowerExpression.h"
#import "BasicFuncExpression.h"
#import "ExpPowerExpression.h"
#import "Variable.h"

#import "ClearCommand.h"
#import "AssignCommand.h"
#import "ExpressionCommand.h"
#import "PlotFuncCommand.h"

#import "ConsoleLexer.h"
#import "ConsoleParser.h"

#import "Matrix.h"
#import "Function.h"
#import "Integer.h"
#import "Fraction.h"
#import "Decimal.h"

extern int yyparse();
extern short DEFAULT_ROUND;
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
        switch(self->parse->type()) {
            case CLEAR_COMMAND: {
                command = [[ClearCommand alloc] init];
                break;
            }
            case ASSIGN_COMMAND:{
                CAssignCommand* cass = (CAssignCommand*)self->parse;
                AssignCommand* ass = [[AssignCommand alloc] init:translate(cass->id->name) value:translate(cass->value)];
                if(nil == [ass exp]) {
                // Failed to translate
                    command = nil;
                } else {
                    command = ass;
                }
                break;
            }
            case PLOTFUNC_COMMAND: {
                CPlotFuncCommand* cpfc = (CPlotFuncCommand*)self->parse;
                PlotFuncCommand* pfc = [[PlotFuncCommand alloc] init:[[Function alloc] init: translate(cpfc->exp)] name:[translate(cpfc->name) description]];
                command = pfc;
                break;
            }
            case PLOTREM_COMMAND:{
                CPlotRemoveCommand* cprc = (CPlotRemoveCommand*)self->parse;
                Expression* identifier = translate(cprc->name);
                NSString* name = identifier == nil? nil:[identifier description];
                PlotRemoveCommand* prc = [[PlotRemoveCommand alloc] init:name];
                command = prc;
                break;
            }
            case CMD_EXP: {
                CExpCommand* cec = (CExpCommand*)self->parse;
                ExpressionCommand* expcmd = [[ExpressionCommand alloc] init:translate(cec->exp)];
                return expcmd;
                break;
            }
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
    if(NULL == input)
        return nil;
    switch(input->type()) {
        case EXP_LIST:
        {
            CExpList* clist = (CExpList*)input;
            ExpressionList* expList = [[ExpressionList alloc] init];
            for(int i = 0 ; i < clist->size(); i++) {
                [expList add:translate(clist->get(i))];
            }
            return expList;
        }
        case EXP_ARITH:
        {
            CArithExpression* carith = (CArithExpression*)input;
            ArithmeticExpression* arith = [[ArithmeticExpression alloc] init:translate(carith->left) opr:carith->opr right:translate(carith->right)];
            return arith;
        }
        case EXP_ID:
        {
            CIdentifier* cid = (CIdentifier*) input;
            Variable* id = [[Variable alloc] init:translate(cid->name)];
            return id;
        }
        case EXP_FUNC:
        {
            CFuncExpression* cf = (CFuncExpression*)input;
            Variable* name = (Variable*)translate(cf->name);
            ExpressionList* params = (ExpressionList*)translate(cf->params);
            // Filter out known basic functions 
            if([name.name isEqualToString:@"sin"] && params.count == 1) {
                return [[BasicFuncExpression alloc] init:BT_SIN base: [params get:0]];
            }
            if([name.name isEqualToString:@"cos"] && params.count == 1) {
                return [[BasicFuncExpression alloc] init:BT_COS base: [params get:0]];
            }
            if([name.name isEqualToString:@"ln"] && params.count == 1) {
                return [[BasicFuncExpression alloc] init:BT_LN base: [params get:0]];
            }
            FuncExpression* func = [[FuncExpression alloc] init:name params:params];
            return func;
        }
        case EXP_POWER: {
            CPowerExpression* cpe = (CPowerExpression*)input;
            Expression* power = [translate(cpe->power) evaluate];
            Expression* base = [translate(cpe->base) evaluate];
            if([power isKindOfClass:[Number class]]) {
                return [[PowerExpression alloc] init:base power:(Number*)power];
            }
            if([base isKindOfClass:[Number class]]) {
                return [[ExpPowerExpression alloc] init:(Number*)base power:power];
            }
            return nil;
        }
        case CONST_MATRIX:
        {
            CMatrix* cm = (CMatrix*)input;
            ExpressionList* expList = (ExpressionList*)translate(cm->content);
            Matrix* matrix = [[Matrix alloc] initWithExpression:expList];
            return matrix;
        }
        case CONST_NUM:
        {
            CNumData* cnd = (CNumData*)input;
            Number* num = nil;
            if(cnd->decimal != NULL) {
                NSDecimalNumber* decimal = [NSDecimalNumber decimalNumberWithString:translate(cnd->decimal)];
                decimal = [decimal decimalNumberByRoundingAccordingToBehavior:[ScaleBehavior get:DEFAULT_ROUND]];
                num = [[Decimal alloc] init:decimal];
            } else {
                num = [Integer construct:cnd->value];
            }
            return num;
            
        }
        default:
            return nil;
    }
}
@end
