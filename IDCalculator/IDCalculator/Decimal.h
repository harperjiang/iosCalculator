//
//  Decimal.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Number.h"

@interface ScaleBehavior : NSObject <NSDecimalNumberBehaviors>

@property(nonatomic) short scale;

+(ScaleBehavior*) get:(short) scale;

@end

@interface Decimal : Number

@property(nonatomic) NSDecimalNumber* value;
@property(nonatomic,strong) ScaleBehavior* scale;

-(Decimal*) init:(NSDecimalNumber*) value;
-(Decimal*) init:(NSDecimalNumber*) value scale:(short) scale;

@end
