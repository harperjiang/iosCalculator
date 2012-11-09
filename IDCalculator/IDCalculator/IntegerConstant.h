//
//  IntegerConstant.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"

@interface IntegerConstant : Constant

@property(nonatomic) NSInteger value;


+(IntegerConstant*) construct:(NSInteger) input;

+(void) initialize;

+(IntegerConstant*) ZERO;
+(IntegerConstant*) ONE;

@end

