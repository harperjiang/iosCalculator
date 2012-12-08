//
//  NumConstant.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "NumConstant.h"
#import "ArithConstant.h"
#import "Integer.h"

@implementation NumConstant

static NumConstant* ONE;
static NumConstant* ZERO;
static NumConstant* NEGAONE;

+(void) initialize {
    if([self class] == [NumConstant class]) {
        ONE = [[NumConstant alloc] init:[Integer ONE]];
        ZERO = [[NumConstant alloc] init:[Integer ZERO]];
        NEGAONE = [[NumConstant alloc] init:[Integer NEGAONE]];
    }
}

+(NumConstant*) construct:(Number*) num {
    if(num == [Integer ONE])
        return ONE;
    if(num == [Integer ZERO])
        return ZERO;
    if(num == [Integer NEGAONE])
        return NEGAONE;
    return [[NumConstant alloc] init:num];
}

+(NumConstant *)constructWithInteger:(NSInteger)num {
    return [NumConstant construct:[Integer construct:num]];
}

+(NumConstant *)ONE {
    return ONE;
}

+(NumConstant*) ZERO {
    return ZERO;
}

+(NumConstant*)NEGAONE {
    return NEGAONE;
}

-(NumConstant *)init:(Number *)number {
    self = [super init];
    if(self) {
        self.number = number;
    }
    return self;
}

-(NSString *)description {
    return [self.number description];
}

-(Constant*)add:(Constant *)input {
    if([input class] == [NumConstant class]) {
        NumConstant* nc = (NumConstant*)input;
        return [NumConstant construct:[self.number add:nc.number]];
    }
    return [[ArithConstant alloc] init:self opr:ADD right:input];
}

-(Constant*)sub:(Constant *)input {
    if([input class] == [NumConstant class]) {
        NumConstant* nc = (NumConstant*)input;
        return [NumConstant construct:[self.number sub:nc.number]];
    }
    return [[ArithConstant alloc] init:self opr:SUB right:input];;
}

-(Constant*)mul:(Constant *)input {
    if([input class] == [NumConstant class]) {
        NumConstant* nc = (NumConstant*)input;
        return [NumConstant construct:[self.number mul:nc.number]];
    }
    return [[ArithConstant alloc] init:self opr:MUL right:input];;
}

-(Constant*)div:(Constant *)input {
    if([input class] == [NumConstant class]) {
        NumConstant* nc = (NumConstant*)input;
        return [NumConstant construct:[self.number div:nc.number]];
    }
    return [[ArithConstant alloc] init:self opr:DIV right:input];
}

@end
