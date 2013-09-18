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
#import "Element.h"
#import "Integer.h"
#import "ViewPort.h"

@implementation Environment

-(Environment*)init {
    self = [super init];
    if(self) {
        // FIXME For test only, add test item to environment
        [self addElement:[[Coordinate alloc] init]];
        FunctionGraph* fg = [[FunctionGraph alloc] init];
        [fg setFunction:[[Function alloc] init]];
        PolynomialExpression* pe = [[PolynomialExpression alloc] init];
        [pe addItem:[Decimal constructDouble:0.017] power:3];
        [[fg function] setExpression:pe];
        [self addElement:fg];
    }
    return self;
}

@end
