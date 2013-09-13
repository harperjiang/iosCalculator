//
//  VariableContext.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "VariableContext.h"

@implementation VariableContext

static VariableContext* instance;

+(void)initialize {
    instance = [[VariableContext alloc] init];
}

+(VariableContext*) instance {
    return instance;
}

-(VariableContext*) init {
    self = [super init];
    if(self) {
        self->_variables = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) assign:(NSString*) name value:(Data*) data {
    [self.variables setValue:data forKey:name];
}

-(Data*) lookup:(NSString*) name {
    return [self.variables objectForKey:name];
}

@end
