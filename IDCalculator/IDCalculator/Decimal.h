//
//  Decimal.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "RealNumber.h"

@interface ScaleBehavior : NSObject <NSDecimalNumberBehaviors>

@property(nonatomic) short scale;

+(ScaleBehavior*) get:(short) scale;

@end

@interface Decimal : RealNumber

@property(nonatomic) NSDecimalNumber* value;
@property(nonatomic,strong) ScaleBehavior* scale;

-(Decimal*) init:(NSDecimalNumber*) value;
-(Decimal*) initWithNumber:(Number*) value;
-(Decimal*) init:(NSDecimalNumber*) value scale:(short) scale;

+(Decimal*) constructDouble: (double) d;
+(Decimal*) constructFloat: (float) f;
@end
