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
    
}

@end
