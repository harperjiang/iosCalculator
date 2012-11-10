//
//  IDCConsole.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "IDCConsole.h"

@implementation IDCConsole

-(IDCConsole*) init {
    self = [super init];
    if(self) {
        self->_buffer = [[NSMutableString alloc] initWithCapacity:100];
        self->_variables = [[NSMutableDictionary alloc] initWithCapacity:100];
    }
    return self;
}

-(void) operate:(NSString *)command {
    [[self buffer] appendString:[NSString stringWithFormat:@"Command: %@\n\n",command]];
    // TODO Execute the command
}

@end
