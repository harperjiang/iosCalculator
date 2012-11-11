//
//  SpecialConstant.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "SpecialConstant.h"

@implementation SpecialConstant

static SpecialConstant* PI;

-(SpecialConstant*) init:(NSString*)name {
    self = [super init];
    if(self) {
        self->_name = name;
    }
    return self;
}

-(NSString*) description {
    return [self name];
}

+(void) initialize {
    if([self class] == [SpecialConstant class]) {
        PI = [[SpecialConstant alloc] init:@"π"];
    }
}

+(SpecialConstant*) PI {
    return PI;
}

@end
