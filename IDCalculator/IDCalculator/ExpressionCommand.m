//
//  ExpressionCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpressionCommand.h"
#import "VariableContext.h"
#import "Data.h"

@implementation ExpressionCommand

-(ExpressionCommand*) init:(Expression *)expression {
    self = [super init];
    if(self) {
        [self setExpression:expression];
    }
    return self;
}

-(void) execute {
    id oldval = [[VariableContext instance] get:KEY_CALCULATE];
    [[VariableContext instance] set:KEY_CALCULATE value:@"true"];
    // Evaluate the expression
    Expression* result = [[self expression] evaluate];
    [[VariableContext instance] set:KEY_CALCULATE value:oldval];
    if(nil != result) {
    // Print the result
        [[IDCConsole instance] output:[result description]];
    }
}

@end
