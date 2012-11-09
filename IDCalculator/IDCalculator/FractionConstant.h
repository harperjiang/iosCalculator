//
//  FractionConstant.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"

@interface FractionConstant : Constant

@property(nonatomic) Constant* numerator;
@property(nonatomic) Constant* denominator;

+ (Constant*) construct:(Constant*) n
                        denominator:(Constant*) d;

@end
