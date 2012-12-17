//
//  ArithmeticFunction.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticFunction.h"
#import "NumConstant.h"
#import "PowerFunction.h"
#import "ExpPowerFunction.h"
#import "Integer.h"
#import "PolynomialFunction.h"
#import "BasicFunction.h"

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
    if([self.left isKindOfClass:[Constant class]] && self.opr == MUL) {
        return [[ArithmeticFunction alloc] init:self.left opr:MUL right:[self.right differentiate:variable]];
    }
    Function* du = (self.left == nil)? nil: [[self left] differentiate:variable];
    Function* dv = [[self right] differentiate:variable];
    Function* result = nil;
    Function* udv = nil, *vdu = nil,*vv = nil;
    if([self opr] >= MUL) {
        udv = [[ArithmeticFunction alloc] init:[self left] opr:MUL right:dv];
        vdu = [[ArithmeticFunction alloc] init:[self right] opr:MUL right:du];
        vv = [[PowerFunction alloc] init:self.right power:[NumConstant construct:[Integer construct:2]]];
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
            // (vdu - udv)/v²
            result = [[ArithmeticFunction alloc] init:[[ArithmeticFunction alloc] init:vdu opr:SUB right:udv] opr:DIV right:vv];
            break;
        default:
            return nil;
    }
    return result;
}

-(Function*) integrate:(Variable *)variable {
    Function* iu = (self.left == nil)? nil:[self.left integrate:variable];
    Function* iv = [self.right integrate:variable];
    if((self.left != nil && iu == nil) || iv == nil)
        return nil;
    switch (self.opr) {
        case ADD:
            return [[ArithmeticFunction alloc] init:iu opr:ADD right:iv];
        case SUB:
            return [[ArithmeticFunction alloc] init:iu opr:SUB right:iv];
        case MUL: {
            // Try to convert to polynomial
            Function* poly = [PolynomialFunction toPolynomial:self];
            if(poly != nil && [poly isKindOfClass:[PolynomialFunction class]]) {
                return [poly integrate:variable];
            }
            return nil;
        }
        case DIV: {
            // Try to convert to polynomial
            Function* poly = [PolynomialFunction toPolynomial:self];
            if(poly != nil && [poly isKindOfClass:[PolynomialFunction class]]) {
                return [poly integrate:variable];
            }
            if([poly isKindOfClass:[ArithmeticFunction class]] && ((ArithmeticFunction*)poly).opr == DIV) {
                ArithmeticFunction* polyedArith = (ArithmeticFunction*)poly;
                if(![polyedArith.left isKindOfClass:[PolynomialFunction class]] || ![polyedArith.right isKindOfClass:[PolynomialFunction class]])
                    return nil;
                PolynomialFunction* leftp = (PolynomialFunction*)polyedArith.left;
                PolynomialFunction* rightp = (PolynomialFunction*)polyedArith.right;
                
                PolynomialFunction* div = [leftp div:rightp];
                PolynomialFunction* mod = [leftp mod:rightp];
                if([mod evaluate] == [NumConstant ZERO]) {
                    // Fully Division
                    return [div integrate:variable];
                } else if([div evaluate] == [NumConstant ZERO] && [rightp order] == 1) {
                    // 1/x format, ln result
                    // c/(ax+b)
                    Constant* coe = [[mod getCoefficient:0] div:[rightp getCoefficient:1]];
                    Function* lnf = [[BasicFunction alloc] init:BT_LN base:rightp];
                    return [[ArithmeticFunction alloc] init:coe opr:MUL right:lnf];
                } else if([rightp order] == 1) {
                    Function* divi = [div integrate:variable];
                    Function* modi = [[[ArithmeticFunction alloc] init:mod opr:DIV right:rightp] integrate:variable];
                    return [[ArithmeticFunction alloc] init:divi opr:ADD right:modi];
                } else {
                    return nil;
                }
            }
        }
        default:
            return nil;
    }
}


-(Function*) evaluate {
    Function* result = [self arithevaluate];
    Function* polyeval = [PolynomialFunction toPolynomial:result];
    if(polyeval != nil) {
        if([polyeval isKindOfClass:[PolynomialFunction class]]){
            return [polyeval evaluate];
        }
        else {
            return polyeval;
        }
    }
    else {
        return result;
    }
}

-(Function*) arithevaluate {
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
        // Merge a+(-x) or a-(-x)
        if((self.opr == ADD || self.opr == SUB) && innerRight.opr == SUB && innerRight.left == nil) {
            Operator newopr = (self.opr + 1) % 2;
            return [[ArithmeticFunction alloc] init:self.left opr:newopr right:innerRight.right];
        }
    }
    
    // Merge PowerFunction
    if([self.left isKindOfClass:[PowerFunction class]] && [self.right isKindOfClass:[PowerFunction class]] && self.opr == MUL) {
        PowerFunction* leftPower = (PowerFunction*)self.left;
        PowerFunction* rightPower = (PowerFunction*)self.right;
        if([[leftPower base] equals:[rightPower base]]) {
            Constant* newpower = [leftPower.power add:rightPower.power];
            return [[PowerFunction alloc] init:leftPower.base power:newpower];
        }
    }
    
    // Merge ExpPowerFunction
    if([self.left isKindOfClass:[ExpPowerFunction class]] && [self.right isKindOfClass:[ExpPowerFunction class]] && self.opr == MUL) {
        ExpPowerFunction* leftPower = (ExpPowerFunction*)self.left;
        ExpPowerFunction* rightPower = (ExpPowerFunction*)self.right;
        Function* newpower = [[[ArithmeticFunction alloc] init:leftPower.power opr:ADD right:rightPower.power] evaluate];
        return [[ExpPowerFunction alloc] init:newpower];
    }
    
    return self;
}

-(NSString*) description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if(self.left != nil) {
        if([self.left isKindOfClass:[ArithmeticFunction class]]) {
            ArithmeticFunction* lefta = (ArithmeticFunction*)self.left;
            if(lefta.opr < 3 && self.opr >= 3) {
                [result appendFormat:@"(%@)",[self.left description]];
            } else {
                [result appendString:[self.left description]];
            }
        } else if([self.left isKindOfClass:[PolynomialFunction class]] && [[(PolynomialFunction*)self.left coefficients] count] > 1 && self.opr >= 3){
            [result appendFormat:@"(%@)",[self.left description]];
        } else if([self.left isKindOfClass:[NumConstant class]]) {
            NumConstant* nc = (NumConstant*)self.left;
            if(![nc.number isKindOfClass:[Integer class]] && self.opr == MUL) {
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
        if(righta.opr < 3 && self.opr >= 2) {
            [result appendFormat:@"(%@)",[self.right description]];
        } else {
            [result appendString:[self.right description]];
        }
    } else if([self.right isKindOfClass:[PolynomialFunction class]] && [(PolynomialFunction*)self.right validCount] > 1){
        [result appendFormat:@"(%@)",[self.right description]];
    } else {
        [result appendString:[self.right description]];
    }
    
    return result;
}

@end
