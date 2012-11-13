//
//  ArithmeticFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"
#import "Operator.h"

@interface ArithmeticFunction : Function

@property(nonatomic) Operator operator;
@property(nonatomic, strong) Function* left;
@property(nonatomic, strong) Function* right;

-(ArithmeticFunction*) init:(Function*)left operator:(Operator)opr right:(Function*) r;

@end
