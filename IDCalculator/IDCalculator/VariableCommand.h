//
//  VariableCommand.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Command.h"

@interface VariableCommand : Command

@property(nonatomic,strong) NSString* name;

-(VariableCommand*) init:(NSString*)name;

@end
