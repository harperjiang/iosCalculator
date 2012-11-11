//
//  Command.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDCConsole.h"

@interface Command : NSObject

@property(nonatomic,strong,readonly) NSString* text;
@property(nonatomic,strong) IDCConsole* console;


-(void) execute;

+(Command*) parse:(NSString*) input;

@end
