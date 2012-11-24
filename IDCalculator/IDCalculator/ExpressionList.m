//
//  ExpressionList.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ExpressionList.h"

@implementation ExpressionList

-(void) add:(Expression *)exp {
    [[self expList] addObject:exp];
}

@end
