//
//  FunctionConverter.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FunctionParser.h"
#import "CalculusParser.h"
#import "CalculusLexer.h"
#import "Variable.h"
#import "Integer.h"
#import "NumConstant.h"
#import "SpecialConstant.h"
#import "BasicFunction.h"
#import "ArithmeticFunction.h"
#import "PowerFunction.h"
#import "ExpPowerFunction.h"
#import "DiffFunction.h"
#import "InteFunction.h"

extern CFunction* calculus_result;
extern int calparse();


@implementation FunctionParser {
    CFunction* parse;
}

+(Function*) parse:(NSString *)input {
    FunctionParser* parser = [[FunctionParser alloc] init];
    [parser innerParse:input];
    return [parser convert];
}

-(void) innerParse:(NSString*)input {
    YY_BUFFER_STATE bufferState = cal_scan_string([input UTF8String]);
    if(!calparse()) {
        self->parse = calculus_result;
    }
    cal_delete_buffer(bufferState);
    return;
}

-(Function*) convert {
    return translate(self->parse);
}

Function* translate(CFunction* cfunc) {
    if(NULL == cfunc)
        return nil;
    switch(cfunc->type()) {
        case CAL_FUNC_ARITH:{
            CArithFunc* car = (CArithFunc*)cfunc;
            ArithmeticFunction* arith = [[ArithmeticFunction alloc] init:translate(car->left) opr:car->opr right:translate(car->right)];
            return arith;
        }
        case CAL_FUNC_POWER: {
            CPowerFunc* cpf = (CPowerFunc*)cfunc;
            Function* base = translate(cpf->base);
            Function* power = translate(cpf->power);
            if(base == [SpecialConstant E]) {
                return [[ExpPowerFunction alloc] init:power];
            } else if([power isKindOfClass:[Constant class]]) {
                return [[PowerFunction alloc] init:base power:(Constant*)power];
            } else {
                return nil;
            }
        }
        case CAL_FUNC_INT: {
            CIntFunc* cintf = (CIntFunc*)cfunc;
            InteFunction* inte = [[InteFunction alloc] init];
            inte.base = translate(cintf->base);
            inte.factor = translate(cintf->factor);
            return inte;
        }
        case CAL_FUNC_DIFF: {
            CDiffFunc* cdf = (CDiffFunc*)cfunc;
            DiffFunction* df = [[DiffFunction alloc] init];
            df.base = translate(cdf->base);
            df.factor = translate(cdf->factor);
            return df;
        }
        case CAL_FUNC_NAME: {
            CNameFunc* namef = (CNameFunc*)cfunc;
            switch(namef->name) {
                case NF_SIN:
                    return [[BasicFunction alloc] init:BT_SIN base:translate(namef->param)];
                case NF_COS:
                    return [[BasicFunction alloc] init:BT_COS base:translate(namef->param)];
                case NF_LN:
                    return [[BasicFunction alloc] init:BT_LN base:translate(namef->param)];
                default:
                    return nil;
            }
        }
        case CAL_VAR: {
            return [Variable x];
        }
        case CAL_CON_NUM: {
            CNumConstant* cnc = (CNumConstant*)cfunc;
            return [[NumConstant alloc] init:[Integer construct:cnc->value]];
        }
        case CAL_CON_SPEC: {
            CSpecialConstant* specc = (CSpecialConstant*)cfunc;
            switch(specc->consType) {
                case CT_E:
                    return [SpecialConstant E];
                case CT_PI:
                    return [SpecialConstant PI];
                default:
                    return nil;
            }
        }
        default:
            return nil;
    }
}

@end
