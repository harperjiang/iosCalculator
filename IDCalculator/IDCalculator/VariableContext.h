//
//  VariableContext.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface VariableContext : NSObject


@property(nonatomic,strong,readonly) NSMutableDictionary* variables;

-(void) assign:(NSString*) name value:(Data*) data;
-(Data*) lookup:(NSString*) name;

+(VariableContext*) instance;
@end
