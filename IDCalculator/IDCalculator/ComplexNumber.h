//
//  ComplexNumber.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Number.h"
#import "RealNumber.h"

@interface ComplexNumber : Number

@property(nonatomic,strong) RealNumber* real;
@property(nonatomic,strong) RealNumber* imaginary;

@end
