//
//  PlotCommand.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/18/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Command.h"
#import "Function.h"

@interface PlotFuncCommand : Command

@property Function* function;
@property NSString* identifier;

-(PlotFuncCommand*) init:(Function*) function name:(NSString*)identifier;

@end

@interface PlotRemoveCommand : Command
@property NSString* identifier;

-(PlotRemoveCommand*) init:(NSString*) identifier;
@end