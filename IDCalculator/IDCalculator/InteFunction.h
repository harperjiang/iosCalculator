//
//  InteFunction.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"

@interface InteFunction : Function

@property(nonatomic,strong) Function* base;
@property(nonatomic,strong) Function* variable;

@end
