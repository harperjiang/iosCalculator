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
@property(nonatomic,strong) RealNumber* left;
@property(nonatomic,strong) RealNumber* right;

-(ArithConstant*) init:(RealNumber*) left opr:(Operator) opr right:(RealNumber*) right;

@end
