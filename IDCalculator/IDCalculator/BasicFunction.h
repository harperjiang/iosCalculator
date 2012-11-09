//
//  BasicFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"

typedef enum _BasicFunctionType {
    SIN=1,
    COS=2,
    LN=3
} BasicFunctionType;

@interface BasicFunction : Function

@property(nonatomic) BasicFunctionType type;

@property(nonatomic,strong) Function* base;

@end
