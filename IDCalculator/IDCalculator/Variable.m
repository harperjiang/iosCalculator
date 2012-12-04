//
//  Variable.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Variable.h"
#import "NumConstant.h"
#import "integer.h"

@implementation Variable

static Variable* x;

+(void)initialize {
    if([self class] == [Variable class]) {
        x = [[Variable alloc] init];
        x.name = @"x";
    }
}

+(Variable*) x {
    return x;
}

-(Function*) evaluate {
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    if([self.name compare:variable.name] == NSOrderedSame)
        return [NumConstant ONE];
    else
        return [NumConstant ZERO];
}

-(NSString*) description {
    return self.name;
}

@end
