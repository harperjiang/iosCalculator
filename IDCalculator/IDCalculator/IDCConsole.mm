//
//  IDCConsole.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "IDCConsole.h"
#import "Command.h"
#import "CommandConverter.h"

@implementation IDCConsole

static IDCConsole* instance;

+(void)initialize {
    instance = [[IDCConsole alloc] init];
}

+(IDCConsole*) instance {
    return instance;
}

-(IDCConsole*) init {
    self = [super init];
    if(self) {
        self->_buffer = [[NSMutableString alloc] initWithCapacity:100];
        [self->_buffer appendString:@">> "];
        [self setPlots:[[NSMutableDictionary alloc] init]];
    }
    return self;
}

-(void) operate:(NSString *)commandText {
    if([commandText length] == 0)
        return;
    // Echo the Command
    [self output:[NSString stringWithFormat:@"%@",commandText]];
    // Execute the command
    Command* command = [CommandConverter parse:commandText];
    if(nil == command) {
        [self error:[NSString stringWithFormat:@"Invalid Command:%@\n",commandText]];
    } else {
        [command execute];
    }
    [[self buffer]appendString:@">> "];
}

-(void) output:(NSString*) displayText {
    [[self buffer] appendFormat:@"%@\n",displayText];
}

-(void) error:(NSString*) errorText {
    [[self buffer] appendFormat:@"Error: %@\n",errorText];

}


@end
