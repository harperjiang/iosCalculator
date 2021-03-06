//
//  VariableContext.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "Stack.h"


FOUNDATION_EXPORT NSString* const KEY_CALCULATE;
FOUNDATION_EXPORT NSString* const KEY_TRANSLATE_CONST;

@interface VariableContext : NSObject

@property(nonatomic,strong,readonly) Stack* content;

-(void) assign:(NSString*) name value:(Expression*) data;
-(void) assignAll:(NSDictionary*) dict;
-(Expression*) lookup:(NSString*) name;
-(void) remove:(NSString*) name;

-(void) set:(NSString*) key value:(id)value;
-(id) get:(NSString*)key;
-(BOOL) isTrue:(NSString*)key;

-(void) push;
-(void) pop;

+(VariableContext*) instance;

@end
