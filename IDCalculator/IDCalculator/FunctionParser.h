//
//  FunctionConverter.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"
#import "CalModel.h"

@interface FunctionParser : NSObject

+(Function*) parse:(NSString*) input;

@end
