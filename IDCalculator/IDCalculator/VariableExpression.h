//
//  VariableExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

@interface VariableExpression : Expression

@property(nonatomic,strong) NSString* name;

-(VariableExpression*) init:(NSString*) name;

@end
