//
//  ArithmeticFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunction.h"
#import "NumConstant.h"

@implementation ArithmeticFunction

-(ArithmeticFunction*) init: (Function*)left opr:(Operator) opr right:(Function*) right {
    self = [super init];
    if(self) {
        [self setLeft:left];
        [self setRight:right];
        [self setOpr:opr];
    }
    return self;
}

-(Function*) differentiate:(Variable *)variable {
    if([self.left isKindOfClass:[Constant class]]) {
        return [[ArithmeticFunction alloc] init:self.left opr:MUL right:[self.right differentiate:variable]];
    }
    Function* du = [[self left] differentiate:variable];
    Function* dv = [[self right] differentiate:variable];
    Function* result = nil;
    Function* udv = nil, *vdu = nil,*uv = nil;
    if([self opr] >= MUL) {
        udv = [[ArithmeticFunction alloc] init:[self left] opr:MUL right:dv];
        vdu = [[ArithmeticFunction alloc] init:[self right] opr:MUL right:du];
        uv = [[ArithmeticFunction alloc] init:[self left] opr:MUL right:[self right]];
    }
    switch([self opr]) {
        case ADD:
        case SUB:
            // du +/- dv
            result = [[ArithmeticFunction alloc] init:du opr:[self opr] right:dv];
            break;
        case MUL:
            // udv + vdu
            result = [[ArithmeticFunction alloc] init:udv opr:ADD right:vdu];
            break;
        case DIV:
            // (udv - vdu)/uv
            result = [[ArithmeticFunction alloc] init:[[ArithmeticFunction alloc] init:udv opr:SUB right:vdu] opr:DIV right:uv];
            break;
        default:
            return nil;
    }
    
    return result;
}

-(Function*) evaluate {
    if(nil != self.left)
        self.left = [self.left evaluate];
    self.right = [self.right evaluate];
    if([self.left isKindOfClass:[NumConstant class]] && [self.right isKindOfClass:[NumConstant class]]) {
        switch(self.opr) {
            case ADD:
                return [(NumConstant*)self.left add:(NumConstant*)self.right];
            case SUB:
                return [(NumConstant*)self.left sub:(NumConstant*)self.right];
            case MUL:
                return [(NumConstant*)self.left mul:(NumConstant*)self.right];
            case DIV:
                return [(NumConstant*)self.left div:(NumConstant*)self.right];
            default:
                return nil;
        }
    }
    if(self.left == nil && [self.right isKindOfClass:[NumConstant class]] && self.opr == SUB) {
        return [[NumConstant ZERO] sub:(NumConstant*)self.right];
    }
    if(![self.left isKindOfClass:[Constant class]] && [self.right isKindOfClass:[Constant class]] && self.opr == MUL) {
        // switch Left and right
        Function* temp = self.left;
        self.left = self.right;
        self.right = temp;
        return [self evaluate];
    }
    
    // If MUL/DIV with ZERO/ONE
    Constant* ZERO = [NumConstant ZERO];
    Constant* ONE = [NumConstant ONE];
    if([self.left isKindOfClass:[Constant class]]) {
        Constant* cleft = (Constant*)self.left;
        if(self.opr == MUL && cleft == ZERO)
            return ZERO;
        if(self.opr == MUL && cleft == ONE)
            return self.right;
        if(self.opr == ADD && cleft == ZERO)
            return self.right;
        if(self.opr == SUB && cleft == ZERO) {
            self.left = nil;
            return self;
        }
    }
    if([self.right isKindOfClass:[Constant class]]) {
        Constant* cright = (Constant*)self.right;
        if(self.opr == MUL && cright == ZERO)
            return ZERO;
        if(self.opr == MUL && cright == ONE)
            return self.left;
        if(self.opr == ADD && cright == ZERO)
            return self.left;
        if(self.opr == SUB && cright == ZERO) {
            return self.left;
        }
    }
    // Merge a*//(b*//x) a+/-(b+/-x)
    if([self.right isKindOfClass:[ArithmeticFunction class]]) {
        ArithmeticFunction* innerRight = (ArithmeticFunction*)self.right;
        if([innerRight opr] / 3 == self.opr / 3 && [innerRight.left isKindOfClass:[Constant class]]) {
            Function* newLeft = [[ArithmeticFunction alloc] init:self.left opr:self.opr right:[innerRight left]];
            Function* newRight = [innerRight right];
            Operator oldopr1 = self.opr;
            Operator oldopr2 = [innerRight opr];
            Operator newopr = 0;
            if(oldopr1/3 == 0) {
                newopr = ((oldopr1 + oldopr2)%2 == 0)?ADD:SUB;
            } else {
                newopr = ((oldopr1 + oldopr2)%2 == 0)?MUL:DIV;
            }
            return [[ArithmeticFunction alloc] init:[newLeft evaluate] opr:newopr right:[newRight evaluate]];
        }
    }
    
    return self;
}

-(NSString*) description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if(self.left != nil) {
        if([self.left isKindOfClass:[ArithmeticFunction class]]) {
            ArithmeticFunction* lefta = (ArithmeticFunction*)self.left;
            if(lefta.opr < 3 && self.opr > 3) {
                [result appendFormat:@"(%@)",[self.left description]];
            } else {
                [result appendString:[self.left description]];
            }
        } else {
            [result appendString:[self.left description]];
        }
    }
    if(!([self.left isKindOfClass:[Constant class]] && self.opr == MUL)) {
        switch(self.opr) {
            case ADD:
                [result appendString:@"+"];
                break;
            case SUB:
                [result appendString:@"-"];
                break;
            case MUL:
                [result appendString:@"*"];
                break;
            case DIV:
                [result appendString:@"/"];
                break;
        }
    }
    if([self.right isKindOfClass:[ArithmeticFunction class]]) {
        ArithmeticFunction* righta = (ArithmeticFunction*)self.right;
        if(righta.opr < 3 && self.opr > 3) {
            [result appendFormat:@"(%@)",[self.right description]];
        } else {
            [result appendString:[self.right description]];
        }
    } else {
        [result appendString:[self.right description]];
    }
    return result;
}

@end
