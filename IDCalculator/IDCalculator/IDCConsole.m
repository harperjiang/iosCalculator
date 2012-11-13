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
        self->_variables = [[NSMutableDictionary alloc] initWithCapacity:100];
    }
    return self;
}

-(void) operate:(NSString *)commandText {
    // Execute the command
    Command* command = [Command parse:commandText];
    NSString* text = [command text];
    [[self buffer] appendFormat:@">>%@\n",text];
    [command execute];
}

-(void) output:(NSString*) displayText {
    [[self buffer] appendFormat:@"%@\n",displayText];
}

-(void) error:(NSString*) errorText {
    [[self buffer] appendFormat:@"Error: %@\n",errorText];

}

-(id) get:(NSString*) var{
    return [[self variables] objectForKey:var];
}

@end
