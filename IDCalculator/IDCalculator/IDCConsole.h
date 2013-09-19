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
@property(nonatomic,strong) NSMutableDictionary* plots;

-(void) operate:(NSString*) command;
-(void) output:(NSString*) string;
-(void) error:(NSString*) string;

+(IDCConsole*) instance;

@end
