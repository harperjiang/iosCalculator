//
//  ArithConstant.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithConstant.h"
#import "ArithmeticExpression.h"
#import "Decimal.h"
#import "VariableContext.h"

@implementation ArithConstant

-(ArithConstant *)init:(RealNumber *)left opr:(Operator)opr right:(RealNumber *)right {
    self = [super init];
    if(self) {
        self.left = left;
        self.right = right;
        self.opr = opr;
    }
    return self;
}

-(Decimal*) toDecimal {
    return (Decimal*)[[[ArithmeticExpression alloc] init:[[self left] toDecimal] opr:[self opr] right:[[self right] toDecimal]] evaluate];
}

-(Expression*) evaluate {
    if([[VariableContext instance] isTrue:KEY_CALCULATE]) {
        return [self toDecimal];
    }
    return self;
}

-(Constant*)add:(RealNumber*)input {
    if(self.opr == 0) {
        [self setOpr:ADD];
        [self setRight:input];
        return self;
    }
    return [[ArithConstant alloc] init:self opr:ADD right:input];
}

-(Constant*)sub:(RealNumber*)input {
    if(self.opr == 0) {
        [self setOpr:SUB];
        [self setRight:input];
        return self;
    }
    return [[ArithConstant alloc] init:self opr:SUB right:input];
}

-(Constant*)mul:(RealNumber*)input {
    if(self.opr == 0) {
        [self setOpr:MUL];
        [self setRight:input];
        return self;
    }
    return [[ArithConstant alloc] init:self opr:MUL right:input];
}

-(Constant*)div:(RealNumber*)input {
    if(self.opr == 0) {
        [self setOpr:DIV];
        [self setRight:input];
        return self;
    }
    return [[ArithConstant alloc] init:self opr:DIV right:input];
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
