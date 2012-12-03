//
//  NumberOperators.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Number.h"


@interface NumberOperators : NSObject

+(Number*) add:(Number*) left right:(Number*) right;

+(Number*) sub:(Number*) left right:(Number*) right;

+(Number*) mul:(Number*) left right:(Number*) right;

+(Number*) div:(Number*) left right:(Number*) right;

@end
