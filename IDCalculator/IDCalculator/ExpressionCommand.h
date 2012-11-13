//
//  ExpressionCommand.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Command.h"
#import "Expression.h"


@interface ExpressionCommand : Command

@property(nonatomic,strong) Expression* expression;

-(ExpressionCommand*) init:(Expression*) expression;

@end
