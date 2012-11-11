//
//  IDCConsole.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "IDCConsole.h"
#import "Command.h"

@implementation IDCConsole

-(IDCConsole*) init {
    self = [super init];
    if(self) {
        self->_buffer = [[NSMutableString alloc] initWithCapacity:100];
        self->_variables = [[NSMutableDictionary alloc] initWithCapacity:100];
    }
    return self;
}

-(void) operate:(NSString *)commandText {
    // Execute the command
    Command* command = [Command parse:commandText];
    [command setConsole:self];
    NSString* text = [command text];
    [[self buffer] appendFormat:@">>%@\n",text];
    [command execute];
}

@end
