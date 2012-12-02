//
//  BasicFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"

typedef enum _BasicFunctionType {
    BT_SIN,
    BT_COS,
    BT_LN
} BasicFunctionType;

@interface BasicFunction : Function



@property(nonatomic) BasicFunctionType type;
@property(nonatomic,strong) Function* base;


-(BasicFunction*) init: (BasicFunctionType) type base:(Function*)base;

@end
