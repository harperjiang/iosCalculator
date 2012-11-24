//
//  ArithmeticExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "Operator.h"

@interface ArithmeticExpression : Expression

@property(nonatomic) Operator opr;
@property(nonatomic,strong) Expression* left;
@property(nonatomic,strong) Expression* right;

-(ArithmeticExpression*) init:(Expression*)left operator:(Operator) opr right:(Expression*) right;

@end
