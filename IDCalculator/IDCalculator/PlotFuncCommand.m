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
#import "BrowseUtils.h"
#import "ViewUtils.h"
#import "Canvas2DView.h"

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
    Environment* env = [BrowseUtils findGraphEnvironment];
    
    // Remove old graphs
    FunctionGraph* oldfg = [[[IDCConsole instance] plots] objectForKey:self.identifier];
    if(oldfg != nil) {
        [env removeElement:oldfg];
    }
    // Add new graphs
    FunctionGraph* fg = [[FunctionGraph alloc] init:[self function]];
    [env addElement:fg];
    [[[IDCConsole instance] plots] setObject:fg forKey:[self identifier]];
    // Refresh
    [[ViewUtils getViewByClass:[Canvas2DView class]] setNeedsDisplay];
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
        [[BrowseUtils findGraphEnvironment] removeElement:fg];
    } else {
        NSArray* elements = [[BrowseUtils findGraphEnvironment] elements];
        for(NSInteger index = 0; index < elements.count; index++) {
            Element* e = (Element*) [elements objectAtIndex:index];
            if([e isKindOfClass:[FunctionGraph class]]) {
                [[BrowseUtils findGraphEnvironment] removeElement:e];
                index--;
            }
        }
    }
    [[ViewUtils getViewByClass:[Canvas2DView class]] setNeedsDisplay];
}

@end