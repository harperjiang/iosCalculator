//
//  ModularIntegerTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ModularInteger.h"

@interface ModularIntegerTest : XCTestCase

@end

@implementation ModularIntegerTest

- (void)testInverse {
    ModularInteger* mi = [[ModularInteger alloc] init:5 mod:31];
    ModularInteger* mi2 = [[ModularInteger alloc] init:3 mod:31];
    XCTAssertEqualObjects(@"12",[[mi div:mi2] description],@"");
}

-(void) testModExp {
    ModularInteger* mi = [[ModularInteger alloc] init:23 mod:371];
    ModularInteger* a = [[ModularInteger alloc] init:1 mod:371];
    for(int i = 1; i < 23424;i++) {
        a = (ModularInteger*)[a mul:mi];
        ModularInteger* b = [mi modExp:i];
        XCTAssertEqualObjects([a description], [b description], [NSString stringWithFormat:@"%d",i]);
    }
}
@end
