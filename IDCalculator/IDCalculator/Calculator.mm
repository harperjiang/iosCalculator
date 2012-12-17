//
//  Calculator.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Calculator.h"
#import "FunctionParser.h"


@implementation Calculator

static Calculator* instance;

+(Calculator*) instance {
    if(nil == instance) {
        instance = [[Calculator alloc] init];
    }
    return instance;
}

-(NSString*) calculate:(NSString *)text {
    Function* func = [FunctionParser parse:text];
    if(nil == func) {
        return @"Error: cannot recognize the input";
    } else {
        Function* eval = [func evaluate];
        if(eval != nil) {
            return [eval description];
        }
        return @"Not available";
    }
}

@end
