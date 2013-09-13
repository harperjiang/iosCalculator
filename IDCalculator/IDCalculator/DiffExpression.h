//
//  DiffFunction.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

@interface DiffExpression : Expression

@property(nonatomic,strong) Expression* base;
@property(nonatomic,strong) Variable* variable;

@end
