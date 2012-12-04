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

-(NSString *)description {
    NSString* format = nil;
    switch(self.opr) {
        case ADD:
            format = @"%@+%@";
            break;
        case SUB:
            format = @"%@-%@";
            break;
        case MUL:
            format = @"%@*%@";
            break;
        case DIV:
            format = @"%@/%@";
            break;
        default:
            return nil;
    }
    return [NSString stringWithFormat:format,[self.left description],[self.right description]];
}

@end
