//
//  BasicFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

typedef enum _BasicFuncType {
    BT_SIN,
    BT_COS,
    BT_LN
} BasicFuncType;

@interface BasicFuncExpression : Expression

@property(nonatomic) BasicFuncType type;
@property(nonatomic,strong) Expression* base;

-(BasicFuncExpression*) init: (BasicFuncType) type base:(Expression*)base;

@end
