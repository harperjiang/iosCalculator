//
//  VariableExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"

@interface ConsoleIdentifier : Expression

@property(nonatomic,strong) NSString* name;

-(ConsoleIdentifier*) init:(NSString*) name;

@end
