//
//  VariableExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ConsoleIdentifier.h"
#import "IDCConsole.h"

@implementation ConsoleIdentifier

-(ConsoleIdentifier*) init:(NSString *)name {
    self = [super init];
    if(self) {
        [self setName:name];
    }
    return self;
}

-(Data*) evaluate {
    Data* value =[[IDCConsole instance] get:[self name]];
    if(value == nil) {
        [[IDCConsole instance] error:[NSString stringWithFormat:@"Variable '%@' doesn't exist",[self name]]];
        return nil;
    }else {
        return value;
    }
}

@end
