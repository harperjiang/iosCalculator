//
//  Environment.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Environment.h"
#import "PartialDrawable.h"
#import "FunctionGraph.h"
#import "Coordinate.h"
#import "PolynomialExpression.h"
#import "BasicFuncExpression.h"
#import "Element.h"
#import "Integer.h"
#import "ViewPort.h"

@implementation Environment

-(Environment*)init {
    self = [super init];
    if(self) {
        [self addElement:[[Coordinate alloc] init]];
    }
    return self;
}

@end
