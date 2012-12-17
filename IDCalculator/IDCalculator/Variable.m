//
//  Variable.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Variable.h"
#import "NumConstant.h"
#import "Fraction.h"
#import "integer.h"
#import "PolynomialFunction.h"


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

-(Function*) integrate:(Variable *)variable {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    NumConstant* oot = [NumConstant construct:[Fraction construct:[Integer construct:1] denominator:[Integer construct:2]]];
    [pf addItem:oot power:2];
    return pf;
}

-(NSString*) description {
    return self.name;
}

-(Boolean) equals:(Function *)another {
    if([another isKindOfClass:[Variable class]]) {
        Variable* av = (Variable*)another;
        return [av.name compare: self.name] == NSOrderedSame;
    }
    return false;
}

@end
