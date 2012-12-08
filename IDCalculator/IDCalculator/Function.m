//
//  Function.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"
#import "Variable.h"
#import "PolynomialFunction.h"

@implementation Function

-(Function*) evaluate {
    return self;
}

-(Function*) integrate:(Variable*) variable {
    return nil;
}

-(Function*) differentiate:(Variable*) variable {
    return nil;
}

-(Boolean)equals:(Function *)another {
    return false;
}

-(NSString*) description {
    Function* poly = [PolynomialFunction toPolynomial:self];
    if(poly != nil) {
        return [poly description];
    }
    return nil;
}

@end
