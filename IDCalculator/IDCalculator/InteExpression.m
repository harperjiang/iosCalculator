//
//  InteFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "InteFunction.h"
#import "PolynomialFunction.h"

@implementation InteFunction

-(Function*) evaluate {
    self.base = [self.base evaluate];
    Function* inte = [self.base integrate:self.variable];
    if(nil != inte) {
        inte = [inte evaluate];
        Function* polyStyle = [PolynomialFunction toPolynomial:inte];
        if(nil != polyStyle)
            return polyStyle;
        return inte;
    } else {
        return nil;
    }
}

@end
