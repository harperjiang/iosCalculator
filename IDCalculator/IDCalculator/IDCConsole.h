//
//  IDCConsole.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDCConsole : NSObject

@property(nonatomic,strong,readonly) NSMutableString* buffer;
@property(nonatomic,strong,readonly) NSMutableDictionary* variables;

-(void) operate:(NSString*) command;

@end
