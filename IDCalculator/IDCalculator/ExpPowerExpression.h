//
//  ExpPowerFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "Number.h"

@interface ExpPowerExpression : Expression

@property(nonatomic,strong) Expression* power;
@property(nonatomic,strong) Number* base;


-(ExpPowerExpression*) init:(Number*) base power:(Expression*) power;
-(ExpPowerExpression*) init:(Expression*) power;

@end
