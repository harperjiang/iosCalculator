//
//  DiffFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DiffExpression.h"
#import "PolynomialExpression.h"

@implementation DiffExpression

-(Expression*) evaluate {
    self.base = [self.base evaluate];
    Expression* diff = [self.base differentiate:self.variable];
    if(diff != nil) {
        diff = [diff evaluate];
        Expression* polyStyle = [PolynomialExpression toPolynomial:diff];
        if(nil != polyStyle)
            return polyStyle;
        return diff;
    } else {
        return nil;
    }
}

@end
