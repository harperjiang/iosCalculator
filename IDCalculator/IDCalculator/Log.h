//
//  ErrorLog.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log : NSObject

+(void) info: (NSString*) message;

+(void) warn: (NSString*) message;

+(void) error: (NSString*) message;

@end
