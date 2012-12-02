//
//  ArithConstant.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"
#import "Operator.h"

@interface ArithConstant : Constant

@property(nonatomic) Operator opr;
@property(nonatomic,strong) Constant* left;
@property(nonatomic,strong) Constant* right;

-(ArithConstant*) init:(Constant*) left opr:(Operator) opr right:(Constant*) right;
@end
