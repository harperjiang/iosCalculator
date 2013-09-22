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
#import "Integer.h"
#import "Fraction.h"
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


+(BOOL) isNotConstant:(RealNumber*) value {
    if([value isKindOfClass:[Integer class]] || [value isKindOfClass:[Fraction class]] || [value isKindOfClass:[Decimal class]]) {
        return true;
    }
    return false;
}

+(Number*) simplify:(ArithConstant*) input {
    if([ArithConstant isNotConstant: input.left] && [ArithConstant isNotConstant:input.right]) {
        return (Number*)[[[ArithmeticExpression alloc] init:input.left opr:input.opr right:input.right] evaluate];
    }
    if(input.opr == ADD) {
        if(input.left == [Integer ZERO])
            return input.right;
        if(input.right == [Integer ZERO])
            return input.left;
    }
    if(input.opr == SUB) {
        if(input.right == [Integer ZERO])
            return input.right;
    }
    if(input.opr == MUL) {
        if(input.left == [Integer ONE]) {
            return input.right;
        }
        if(input.left == [Integer ZERO]) {
            return [Integer ZERO];
        }
        if(input.right == [Integer ONE]) {
            return input.left;
        }
        if(input.right == [Integer ZERO]) {
            return [Integer ZERO];
        }
    }
    if(input.opr == DIV) {
        if(input.left == [Integer ZERO]) {
            return [Integer ZERO];
        }
        if(input.right == [Integer ONE]) {
            return input.left;
        }
        if(input.right == [Integer ZERO]) {
            return [Decimal nan];
        }
    }
    return input;
}

-(Number*)add:(RealNumber*)input {
    ArithConstant* result = nil;
    if(self.opr == NOP) {
        [self setOpr:ADD];
        [self setRight:input];
        result = self;
    } else if([ArithConstant isNotConstant:input] && (self.opr == ADD || self.opr == SUB)) {
        if([ArithConstant isNotConstant:self.left]) {
            self.left = (RealNumber*) [self.left add: input];
        } else if([ArithConstant isNotConstant:self.right]) {
            self.right = (RealNumber*) ((self.opr == ADD)?[self.right add:input]:[self.right sub:input]);
        }
        result = self;
    }
    result = (result == nil)?[[ArithConstant alloc] init:self opr:ADD right:input]:result;
    return [ArithConstant simplify: result];
}

-(Number*)sub:(RealNumber*)input {
    ArithConstant* result = nil;
    if(self.opr == NOP) {
        [self setOpr:SUB];
        [self setRight:input];
        result = self;
    } else if([ArithConstant isNotConstant:input] && (self.opr == ADD || self.opr == SUB)) {// Merge
        if([ArithConstant isNotConstant:self.left]) {
            self.left = (RealNumber*)[self.left sub:input];
        }
        else if ([ArithConstant isNotConstant:self.right]) {
            self.right = (RealNumber*)(self.opr == ADD?[self.right sub:input]:[self.right add:input]);
        }
        result = self;
    }
    result = (result == nil)?[[ArithConstant alloc] init:self opr:SUB right:input]:result;
    return [ArithConstant simplify: result];
}

-(Number*)mul:(RealNumber*)input {
    ArithConstant* result = nil;
    if(self.opr == NOP) {
        [self setOpr:MUL];
        [self setRight:input];
        result = self;
    } else if([ArithConstant isNotConstant:input] && (self.opr == MUL || self.opr == DIV)) {
        if([ArithConstant isNotConstant:self.left]) {
            self.left = (RealNumber*)[self.left mul:input];
        }
        if([ArithConstant isNotConstant:self.right]) {
            self.right = (RealNumber*) (self.opr == MUL?[self.right mul:input]:[self.right div:input]);
        }
        result = self;
    }
    result = (result == nil)?[[ArithConstant alloc] init:self opr:MUL right:input]:result;
    return [ArithConstant simplify: result];
}

-(Number*)div:(RealNumber*)input {
    ArithConstant* result = nil;
    if(self.opr == NOP) {
        [self setOpr:DIV];
        [self setRight:input];
        result = self;
    } else if([ArithConstant isNotConstant:input] && (self.opr == MUL || self.opr == DIV)) {
        if([ArithConstant isNotConstant:self.left]) {
            self.left = (RealNumber*)[self.left div:input];
        }
        if([ArithConstant isNotConstant:self.right]) {
            self.right = (RealNumber*)(self.opr == DIV?[self.right mul:input]:[self.right div:input]);
        }
        result = self;
    }
    result = (result == nil)?[[ArithConstant alloc] init:self opr:DIV right:input]:result;
    return [ArithConstant simplify: result];
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
