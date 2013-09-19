//
//  PlotCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/18/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "PlotFuncCommand.h"
#import "Environment.h"
#import "VariableContext.h"
#import "FunctionGraph.h"
#import "IDCConsole.h"

@implementation PlotFuncCommand

-(PlotFuncCommand*) init:(Function*) function name:(NSString*)identifier{
    self = [super init];
    if(self) {
        self.function = function;
        self.identifier = identifier;
    }
    return self;
}

-(void) execute {
    FunctionGraph* fg = [[FunctionGraph alloc] init:[self function]];
    [[Environment main] addElement:fg];
    [[[IDCConsole instance] plots] setObject:fg forKey:[self identifier]];
}

@end

@implementation PlotRemoveCommand

-(PlotRemoveCommand*) init:(NSString *)identifier {
    self = [super init];
    if(self) {
        self.identifier = identifier;
    }
    return self;
}

-(void) execute {
    if(self.identifier != nil) {
        FunctionGraph* fg = (FunctionGraph*)[[[IDCConsole instance] plots] objectForKey:self.identifier];
        [[Environment main] removeElement:fg];
    } else {
        NSArray* elements = [[Environment main] elements];
        for(NSInteger index = 0; index < elements.count; index++) {
            Element* e = (Element*) [elements objectAtIndex:index];
            if([e isKindOfClass:[FunctionGraph class]]) {
                [[Environment main] removeElement:e];
                index--;
            }
        }
    }
}

@end