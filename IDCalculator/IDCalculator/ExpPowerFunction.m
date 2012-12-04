//
//  ExpPowerFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpPowerFunction.h"
#import "ArithmeticFunction.h"
#import "NumConstant.h"
#import "PowerFunction.h"

@implementation ExpPowerFunction

-(ExpPowerFunction*) init:(Function *)power {
    self = [super init];
    if(self) {
        [self setPower:power];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    // e^f(x) = e^f(x) *f'(x)
    Function* dpower = [[self power] differentiate:variable];
    Function* result = [[ArithmeticFunction alloc] init:self opr:MUL right:dpower];
    return  result;
}

-(Function*) evaluate {
    self.power = [self.power evaluate];
    return self;
}

-(NSString*) description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:20];
    [buffer appendString:@"e"];
    if([self.power isKindOfClass:[NumConstant class]]) {
        NSString* powerstr = [PowerFunction stringForPower:(NumConstant*)self.power];
        if(powerstr != nil) {
            [buffer appendString:powerstr];
            return buffer;
        }
    }
    if([self.power isKindOfClass:[NumConstant class]]) {
        [buffer appendFormat:@"^%@",[self.power description]];
    } else {
        [buffer appendFormat:@"^(%@)",[self.power description]];
    }
    return buffer;
}

@end
