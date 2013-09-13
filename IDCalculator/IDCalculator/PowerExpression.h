//
//  PowerFunction.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Number.h"
#import "Expression.h"

@interface PowerExpression : Expression

@property(nonatomic,strong) Expression* base;
@property(nonatomic,strong) Number* power;

-(PowerExpression*) init:(Expression*)base power:(Number*)power;
+(NSString*) stringForPower:(Number*) val;
@end
