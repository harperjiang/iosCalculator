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
        self->_content = [[Stack alloc] init];
        NSMutableDictionary* current = [[NSMutableDictionary alloc] init];
        [current setValue:[[NSMutableDictionary alloc] init] forKey:@"variables"];
        [current setValue:[[NSMutableDictionary alloc] init] forKey:@"configures"];
        [self->_content push:current];
    }
    return self;
}

-(NSMutableDictionary*) variables {
    return (NSMutableDictionary*)[(NSDictionary*)[[self content] peek] objectForKey: @"variables"];
}

-(NSMutableDictionary*) configures {
    return (NSMutableDictionary*)[(NSDictionary*)[[self content] peek] objectForKey: @"configures"];
}

-(void) assign:(NSString*) name value:(Data*) data {
    [[self variables] setObject:data forKey:name];
}

-(void) assignAll:(NSDictionary *)dict {
    NSEnumerator* enume = [dict keyEnumerator];
    id object;
    while((object = [enume nextObject]) != nil) {
        [self assign:(NSString*)object value:(Data*)[dict objectForKey:(NSString*)object]];
    }
}

-(Data*) lookup:(NSString*) name {
    return [[self variables] objectForKey:name];
}

-(void) remove:(NSString *)name {
    [[self variables] removeObjectForKey:name];
}

-(void) set:(NSString*)key value:(id) value {
    [[self configures] setObject:value forKey:key];
}

-(id) get:(NSString*) key {
    return [[self configures] objectForKey:key];
}

-(BOOL) isTrue:(NSString *)key {
    id val = [[self configures] objectForKey:key];
    return val != nil;
}

-(void) push {
    NSMutableDictionary* newinst = [[NSMutableDictionary alloc] init];
    [newinst setObject:[[NSMutableDictionary alloc] init] forKey:@"variables"];
    [newinst setObject:[[NSMutableDictionary alloc] init] forKey:@"configures"];
    [self.content push:newinst];
}

-(void) pop {    
    [[self content] pop];
}

@end
