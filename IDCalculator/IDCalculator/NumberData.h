//
//  NumberData.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Data.h"

@interface NumberData : Data

@property(strong,nonatomic) Number* number;

-(NumberData*) init:(Number*) num;

@end
