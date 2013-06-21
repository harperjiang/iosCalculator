//
//  PolynomialFunction.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Function.h"
#import "Constant.h"
#import "NumConstant.h"


@interface PolynomialFunction : Function

@property Variable* variable;
@property NSMutableArray* coefficients;

-(PolynomialFunction*) init;

-(void) addItem: (Constant*) coefficient power:(NSInteger)power;
-(Constant*) getCoefficient:(NSInteger) power;

-(NSInteger) order;

-(PolynomialFunction*) add:(PolynomialFunction*) another;
-(PolynomialFunction*) sub:(PolynomialFunction*) another;
-(PolynomialFunction*) mul:(PolynomialFunction*) another;
-(PolynomialFunction*) div:(PolynomialFunction*) another;
-(PolynomialFunction*) mod:(PolynomialFunction*) another;

-(PolynomialFunction*) power:(Constant*) power;

-(NSInteger) validCount;

+(PolynomialFunction*) toPolynomial:(Function*) func;
+(PolynomialFunction*) toPolynomial:(Function*) func under:(Variable*) var;
+(Boolean) polynomialEqual:(Function*) left right:(Function*) right;

@end
