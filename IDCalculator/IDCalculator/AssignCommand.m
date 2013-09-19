//
//  DefineCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "AssignCommand.h"
#import "VariableContext.h"
#import "Data.h"

@implementation AssignCommand

-(AssignCommand*) init:(NSString *)name value:(Expression *)exp {
    self = [super init];
    if(self) {
        [self setName:name];
        [self setExp:exp];
    }
    return self;
}

-(void) execute {
    Expression* object = [[self exp] evaluate];
    [[VariableContext instance] assign:[self name] value:object];
    // Set up the display
    [[IDCConsole instance] output:[NSString stringWithFormat:@"%@ =\n%@",[self name],[object description]]];
}

@end
