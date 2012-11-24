//
//  DefineCommand.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Command.h"
#import "Expression.h"

@interface AssignCommand : Command

@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) Expression* exp;

-(AssignCommand*) init:(NSString*) name value: (Expression*) exp;

@end
