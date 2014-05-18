//
//  VariableTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "VariableTest.h"
#import "Variable.h"

@implementation VariableTest

-(void)testEquals {
    Variable* x = [Variable x];
    Variable* anotherx = [[Variable alloc] init];
    anotherx.name = @"x";
    Variable* y = [[Variable alloc] init];
    y.name = @"y";
    XCTAssertTrue([x equals:anotherx],@"");
    XCTAssertFalse([x equals:y],@"");
}

@end
