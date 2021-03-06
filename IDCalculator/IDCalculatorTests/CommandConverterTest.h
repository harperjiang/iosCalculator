//
//  CommandConverterTest.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CommandConverterTest : XCTestCase

-(void) testParseClear;

-(void) testParseAssignWrongMatrix;

-(void) testParseAssign;

-(void) testParseExpId;

-(void) testParseArith;

-(void) testParseSingleQuote;

-(void) testParsingFunction;

-(void) testParseDecimal;

-(void) testParsePlot;

-(void) testParseRemove;

-(void) testParseExp;

@end
