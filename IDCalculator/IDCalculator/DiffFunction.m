//
//  DiffFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DiffFunction.h"
#import "PolynomialFunction.h"

@implementation DiffFunction

-(Function*) evaluate {
    self.base = [self.base evaluate];
    Function* diff = [[self.base differentiate:self.variable] evaluate];
    Function* polyStyle = [PolynomialFunction toPolynomial:diff];
    if(nil != polyStyle)
        return polyStyle;
    return diff;
}

@end
