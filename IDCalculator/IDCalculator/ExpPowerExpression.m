//
//  ExpPowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpPowerExpression.h"
#import "ArithmeticExpression.h"
#import "Number.h"
#import "PowerExpression.h"

@implementation ExpPowerExpression

-(ExpPowerExpression*) init:(Expression *)power {
    self = [super init];
    if(self) {
        [self setPower:power];
    }
    return self;
}

-(Expression*) differentiate:(Variable *)variable {
    // e^f(x) = e^f(x) *f'(x)
    Expression* dpower = [[self power] differentiate:variable];
    Expression* result = [[ArithmeticExpression alloc] init:self opr:MUL right:dpower];
    return result;
}

-(Expression*) integrate:(Variable *)variable {
    // TODO Not implemented
    return nil;
}

-(Expression*) evaluate {
    self.power = [self.power evaluate];
    return self;
}

-(NSString*) description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:20];
    [buffer appendString:@"e"];
    if([self.power isKindOfClass:[Number class]]) {
        NSString* powerstr = [PowerExpression stringForPower:(Number*)self.power];
        if(powerstr != nil) {
            [buffer appendString:powerstr];
            return buffer;
        }
    }
    if([self.power isKindOfClass:[Number class]]) {
        [buffer appendFormat:@"^%@",[self.power description]];
    } else {
        [buffer appendFormat:@"^(%@)",[self.power description]];
    }
    return buffer;
}

@end
