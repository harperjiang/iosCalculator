//
//  ModularInteger.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Integer.h"

@interface ModularInteger : Integer

@property(nonatomic) NSInteger mod;

-(ModularInteger*) init:(NSInteger) value mod:(NSInteger)mod;
-(ModularInteger*) modInverse;
-(ModularInteger*) modExp:(NSInteger)exp;

@end

@interface Pulverizer: NSObject

@property(nonatomic) NSInteger a;
@property(nonatomic) NSInteger b;
@property(nonatomic) NSInteger quotient;
@property(nonatomic) NSInteger remaining;
@property(nonatomic) NSInteger x1;
@property(nonatomic) NSInteger y1;
@property(nonatomic) NSInteger x2;
@property(nonatomic) NSInteger y2;

-(Pulverizer*) init:(NSInteger) a b:(NSInteger)b;
-(void) round;
-(void) calculate;

@end