//
//  DefineCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "AssignCommand.h"

@implementation AssignCommand


-(AssignCommand*) init:(NSString *)name value:(id)object {
    self = [super init];
    if(self) {
        [self setName:name];
        [self setObject:object];
    }
    return self;
}

-(AssignCommand*) init:(NSString *)name expression:(Expression *)exp {
    self = [super init];
    if(self) {
        [self setName:name];
        [self setExp:exp];
    }
    return self;
}

-(void) execute {
    if([self object] == nil)
       [self setObject:[[self exp] evaluate]];
    [[[IDCConsole instance] variables] setValue:[self object] forKey:[self name]];
    // Set up the display
    [[IDCConsole instance] output:[NSString stringWithFormat:@"%@=\n%@",[self name],[[self object] description]]];
}

@end
