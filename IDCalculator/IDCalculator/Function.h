//
//  Function.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expression.h"

@class Variable;

@interface Function : NSObject

@property (nonatomic,strong) Expression* expression;

-(Function*) init:(Expression*) exp;

-(Function*) evaluate;

-(Boolean) equals:(Function*) another;

@end
