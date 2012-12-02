//
//  NumConstant.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"
#import "Number.h"

@interface NumConstant : Constant

@property(nonatomic,strong) Number* number;

-(NumConstant*) init:(Number*) number;

+(NumConstant*) ONE;
+(NumConstant*) ZERO;

@end
