//
//  PowerFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"
#import "Constant.h"
#import "NumConstant.h"

@interface PowerFunction : Function

@property(nonatomic,strong) Function* base;
@property(nonatomic,strong) Constant* power;

-(PowerFunction*) init:(Function*)base power:(Constant*)power;
+(NSString*) stringForPower:(NumConstant*) val;
@end
