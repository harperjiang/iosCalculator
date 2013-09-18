//
//  SpecialConstant.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "SpecialConstant.h"
#import "VariableContext.h"
#import "Expression.h"
#import "Decimal.h"
#include "math.h"

@implementation SpecialConstant

static SpecialConstant* PI;
static SpecialConstant* E;

static Decimal* PI_VAL;
static Decimal* E_VAL;

-(SpecialConstant*) init:(NSString*)name {
    self = [super init];
    if(self) {
        self->_name = name;
    }
    return self;
}

-(Decimal*) toDecimal {
    if([[self name] isEqualToString:@"π"]) {
        return PI_VAL;
    }
    if([[self name] isEqualToString:@"e"]) {
        return E_VAL;
    }
    return nil;
}

-(Expression*) evaluate {
    if([[VariableContext instance] isTrue:@"calculate"]) {
        return [self toDecimal];
    }
    return self;
}

-(NSString*) description {
    return [self name];
}

+(void) initialize {
    if([self class] == [SpecialConstant class]) {
        PI = [[SpecialConstant alloc] init:@"π"];
        E = [[SpecialConstant alloc] init:@"e"];
        PI_VAL = [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithDouble:M_PI]];
        E_VAL = [[Decimal alloc] init:[[NSDecimalNumber alloc] initWithDouble:M_E]];
    }
}

+(SpecialConstant*) PI {
    return PI;
}

+(SpecialConstant*) E {
    return E;
}
@end
