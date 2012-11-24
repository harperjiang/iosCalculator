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
#import "NumberData.h"

@implementation VectorTest


-(void) testVar {
    ExpressionList* row = [[ExpressionList alloc] init];
    for(int i = 0 ; i < 10 ; i ++) {
        [row add:[[NumberData alloc] init:[Integer construct:i]]];
    }
    ExpressionList* array = [[ExpressionList alloc] init];
    [array add:row];
    Vector* v = [[Vector alloc] init:array];
    for(int i = 0 ; i < 10 ; i++) {
        NSString* expect = [NSString stringWithFormat:@"%d",i];
        STAssertEqualObjects([[v val:i] description],expect,@"");
    }
    
}

@end
