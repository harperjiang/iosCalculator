//
//  Integer.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Number.h"

@interface Integer : Number

@property(nonatomic) NSInteger value;


+(Integer*) construct:(NSInteger) input;

+(void) initialize;

+(Integer*) ZERO;
+(Integer*) ONE;
+(Integer*) NEGAONE;

@end
