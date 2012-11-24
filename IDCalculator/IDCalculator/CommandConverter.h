//
//  CommandConverter.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#include "CModel.h"

@interface CommandConverter : NSObject

-(Command*) convert;

-(void) innerParse:(NSString*)input;

+(Command*) parse:(NSString*) input;

@end
