//
//  VariableExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "VariableExpression.h"
#import "IDCConsole.h"

@implementation VariableExpression

-(VariableExpression*) init:(NSString *)name {
    self = [super init];
    if(self) {
        [self setName:name];
    }
    return self;
}

-(id) evaluate {
    return [[IDCConsole instance] get:[self name]];
}

@end
