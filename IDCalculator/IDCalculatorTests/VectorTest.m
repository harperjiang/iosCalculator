//
//  VectorTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "VectorTest.h"
#import "Vector.h"
#import "Integer.h"
#import "ExpressionList.h"

@implementation VectorTest


-(void) testVar {
    NSMutableArray* row = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < 10 ; i ++) {
        [row addObject:[Integer construct:i]];
    }
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:row];
    Vector* v = [[Vector alloc] init:array];
    for(int i = 0 ; i < 10 ; i++) {
        NSString* expect = [NSString stringWithFormat:@"%d",i];
        STAssertEqualObjects([[v val:i] description],expect,@"");
    }
    
}

@end
