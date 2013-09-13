//
//  Fraction.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "RealNumber.h"
#import "Integer.h"

@interface Fraction : RealNumber

@property(nonatomic) Number* numerator;
@property(nonatomic) Number* denominator;

-(Fraction*) init:(Integer*) numerator denominator:(Integer*) denominator;

+(Number*) construct:(Number*) n denominator:(Number*) d;

@end
