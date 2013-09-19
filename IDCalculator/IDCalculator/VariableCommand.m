//
//  VariableCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "VariableCommand.h"
#import "VariableContext.h"

@implementation VariableCommand

-(VariableCommand*) init:(NSString *)name {
    self = [super init];
    if(self) {
        [self setName:name];
    }
    return self;
}

-(void) execute {
    id object = [[VariableContext instance] lookup:[self name]];
    if(object == nil) {
        [[IDCConsole instance] error:[NSString stringWithFormat:@"Cannot find variable: %@",[self name]]];
    } else {
        [[IDCConsole instance] output:[NSString stringWithFormat:@"%@ =\n%@",[self name],[object description]]];
    }
}

@end
