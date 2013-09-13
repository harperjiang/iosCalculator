//
//  InteFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "InteExpression.h"
#import "PolynomialExpression.h"

@implementation InteExpression

-(Expression*) evaluate {
    self.base = [self.base evaluate];
    Expression* inte = [self.base integrate:self.variable];
    if(nil != inte) {
        inte = [inte evaluate];
        Expression* polyStyle = [PolynomialExpression toPolynomial:inte];
        if(nil != polyStyle)
            return polyStyle;
        return inte;
    } else {
        return nil;
    }
}

@end
