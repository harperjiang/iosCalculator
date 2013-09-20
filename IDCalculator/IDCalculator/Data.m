//
//  Data.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Data.h"
#import "Integer.h"
#import "Variable.h"
#import "ArithmeticExpression.h"

@implementation Data

-(Data*) evaluate {
    return self;
}

-(Data*) add:(Data *)another {
    return nil;
}

-(Data*) sub:(Data *)another {
    return nil;
}

-(Data*) mul:(Data *)another {
    return nil;
}

-(Data*) div:(Data *)another {
    return nil;
}

-(Data*) pow:(NSInteger)power {
    return nil;
}

-(Expression*) differentiate:(Variable *)v {
    return [Integer ZERO];
}

-(Expression*) integrate:(Variable *)v {
    return [[ArithmeticExpression alloc] init:self opr:MUL right:v];
}

@end
