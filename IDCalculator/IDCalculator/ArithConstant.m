//
//  ArithConstant.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithConstant.h"

@implementation ArithConstant

-(ArithConstant *)init:(Constant *)left opr:(Operator)opr right:(Constant *)right {
    self = [super init];
    if(self) {
        self.left = left;
        self.right = right;
        self.opr = opr;
    }
    return self;
}

@end
