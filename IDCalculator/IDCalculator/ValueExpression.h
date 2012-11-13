//
//  ValueExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

@interface ValueExpression : Expression

@property(nonatomic,strong) id value;

-(ValueExpression*) init:(id)value;

@end
