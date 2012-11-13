//
//  VectorTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "VectorTest.h"
#import "Vector.h"
#import "IntegerConstant.h"

@implementation VectorTest

-(void) testInit {
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i ++) {
        [array insertObject:[IntegerConstant construct:i] atIndex:i];
    }
    Vector* v = [[Vector alloc] init:array];
    STAssertNotNil(v, @"Should not be nil");
}

-(void) testVar {
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0 ; i < 10 ; i ++) {
        [array insertObject:[IntegerConstant construct:i] atIndex:i];
    }
    Vector* v = [[Vector alloc] init:array];
    for(int i = 0 ; i < 10 ; i++) {
        NSString* expect = [NSString stringWithFormat:@"%d",i];
        STAssertEqualObjects([[v val:i] description],expect,@"");
    }
    
}

@end
