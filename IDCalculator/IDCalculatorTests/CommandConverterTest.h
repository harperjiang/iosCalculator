//
//  CommandConverterTest.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface CommandConverterTest : SenTestCase

-(void) testParseClear;

-(void) testParseAssign;

-(void) testParseVar;
@end