//
//  Fraction.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Number.h"

@interface Fraction : Number

@property(nonatomic) Number* numerator;
@property(nonatomic) Number* denominator;

+(Number*) construct:(Number*) n
            denominator:(Number*) d;

@end
