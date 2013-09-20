//
//  PolynomialExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expression.h"
#import "Variable.h"

@interface PolynomialExpression : Expression

@property Variable* variable;
@property NSMutableArray* coefficients;

-(PolynomialExpression*) init;

-(void) addItem: (Data*) coefficient power:(NSInteger)power;
-(Data*) getCoefficient:(NSInteger) power;

-(NSInteger) order;
-(NSInteger) degree;

-(PolynomialExpression*) add:(PolynomialExpression*) another;
-(PolynomialExpression*) sub:(PolynomialExpression*) another;
-(PolynomialExpression*) mul:(PolynomialExpression*) another;
-(PolynomialExpression*) div:(PolynomialExpression*) another;
-(PolynomialExpression*) mod:(PolynomialExpression*) another;

-(PolynomialExpression*) power:(Data*) power;

-(NSInteger) validCount;

+(PolynomialExpression*) toPolynomial:(Expression*) func;
+(PolynomialExpression*) toPolynomial:(Expression*) func under:(Variable*) var;

@end
