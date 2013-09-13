//
//  ExpPowerFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"

@interface ExpPowerFunction : Function

@property(nonatomic,strong) Function* power;

-(ExpPowerFunction*) init:(Function*) power;

@end
