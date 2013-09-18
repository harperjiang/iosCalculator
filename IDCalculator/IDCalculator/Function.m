//
//  Function.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"
#import "Variable.h"
#import "VariableContext.h"

@implementation Function

-(Function*) init:(Expression *)exp {
    self = [super init];
    if(self) {
        [self setExpression:exp];
    }
    return self;
}

-(Boolean)equals:(Function *)another {
    return false;
}

-(Function*) evaluate {
    return [[Function alloc] init:[[self expression] evaluate]];
}

-(Decimal*) calculate:(NSDictionary*) vars {
    [[VariableContext instance] push];
    [[VariableContext instance] assignAll:vars];
    Decimal* result = (Decimal*)[[self expression] evaluate];
    [[VariableContext instance] pop];
    return result;
}

-(NSString*) description {
    if([self expression] == nil)
        return nil;
    return [[self expression] description];
}

@end
