//
//  Variable.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Variable.h"
#import "VariableContext.h"
#import "PolynomialExpression.h"
#import "Fraction.h"
#import "integer.h"

@implementation Variable

static Variable* x;

+(void)initialize {
    if([self class] == [Variable class]) {
        x = [[Variable alloc] init:@"x"];
    }
}

+(Variable*) x {
    return x;
}

-(Variable*) init:(NSString *)name {
    self = [super init];
    if(self){
        [self setName:name];
    }
    return self;
}


-(Expression*) evaluate {
    Data* value =[[VariableContext instance] lookup:[self name]];
    if(value == nil) {
        return self;
    }else {
        return value;
    }
}


-(Expression*) differentiate:(Variable *)variable {
    if([self.name compare:variable.name] == NSOrderedSame)
        return [Integer ONE];
    else
        return [Integer ZERO];
}

-(Expression*) integrate:(Variable *)variable {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    Number* oot = [Fraction construct:[Integer construct:1] denominator:[Integer construct:2]];
    [pf addItem:oot power:2];
    return pf;
}

-(NSString*) description {
    return self.name;
}

-(Boolean) equals:(Expression *)another {
    if([another isKindOfClass:[Variable class]]) {
        Variable* av = (Variable*)another;
        return [av.name compare: self.name] == NSOrderedSame;
    }
    return false;
}

@end
