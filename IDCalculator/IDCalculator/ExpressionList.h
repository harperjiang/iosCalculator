//
//  ExpressionList.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

@interface ExpressionList : Expression

@property(strong,nonatomic) NSMutableArray* expList;

-(void) add:(Expression*) exp;

@end
