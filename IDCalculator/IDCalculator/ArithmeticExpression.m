//
//  ArithmeticExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ArithmeticExpression.h"
#import "PowerExpression.h"
#import "PolynomialExpression.h"
#import "ExpPowerExpression.h"
#import "BasicFuncExpression.h"
#import "Integer.h"
#import "Matrix.h"

@implementation ArithmeticExpression

-(ArithmeticExpression*) init:(Expression *)left opr:(Operator)opr right:(Expression *)right {
    self = [super init];
    if(self) {
        [self setLeft:left];
        [self setRight: right];
        [self setOpr:opr];
    }
    return self;
}

-(Boolean) equals:(Expression *)another {
    if([another isKindOfClass:[ArithmeticExpression class]]) {
        ArithmeticExpression* aa = (ArithmeticExpression*)another;
        return [Expression equals:[self left] another:[aa left]] && [Expression equals:[self right] another:[aa right]] && [self opr] == [aa opr];
    }
    return false;
}

-(Expression*) evaluate {
    Expression* result = [self arithevaluate];
    Expression* polyeval = [PolynomialExpression toPolynomial:result];
    if(polyeval != nil) {
        if([polyeval isKindOfClass:[PolynomialExpression class]]){
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

-(Expression*) arithevaluate {
    if(nil != self.left)
        self.left = [self.left evaluate];
    self.right = [self.right evaluate];
    if([self.left isKindOfClass:[Data class]] && [self.right isKindOfClass:[Data class]]) {
        switch(self.opr) {
            case ADD:
                return [(Data*)self.left add:(Data*)self.right];
            case SUB:
                return [(Data*)self.left sub:(Data*)self.right];
            case MUL:
                return [(Data*)self.left mul:(Data*)self.right];
            case DIV:
                return [(Data*)self.left div:(Data*)self.right];
            default:
                return nil;
        }
    }
    if(self.left == nil && [self.right isKindOfClass:[Number class]] && self.opr == SUB) {
        return [[Integer ZERO] sub:(Number*)self.right];
    }
    if(![self.left isKindOfClass:[Data class]] && [self.right isKindOfClass:[Data class]] && self.opr == MUL) {
        // switch Left and right
        Expression* temp = self.left;
        self.left = self.right;
        self.right = temp;
        return [self evaluate];
    }
    
    // If MUL/DIV with ZERO/ONE
    Integer* ZERO = [Integer ZERO];
    Integer* ONE = [Integer ONE];
    if([self.left isKindOfClass:[Data class]]) {
        Data* cleft = (Data*)self.left;
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
    if([self.right isKindOfClass:[Data class]]) {
        Data* cright = (Data*)self.right;
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
    if([self.right isKindOfClass:[ArithmeticExpression class]]) {
        ArithmeticExpression* innerRight = (ArithmeticExpression*)self.right;
        if([innerRight opr] / 3 == self.opr / 3 && [innerRight.left isKindOfClass:[Data class]]) {
            Expression* newLeft = [[ArithmeticExpression alloc] init:self.left opr:self.opr right:[innerRight left]];
            Expression* newRight = [innerRight right];
            Operator oldopr1 = self.opr;
            Operator oldopr2 = [innerRight opr];
            Operator newopr = 0;
            if(oldopr1/3 == 0) {
                newopr = ((oldopr1 + oldopr2)%2 == 0)?ADD:SUB;
            } else {
                newopr = ((oldopr1 + oldopr2)%2 == 0)?MUL:DIV;
            }
            return [[ArithmeticExpression alloc] init:[newLeft evaluate] opr:newopr right:[newRight evaluate]];
        }
        // Merge a+(-x) or a-(-x)
        if((self.opr == ADD || self.opr == SUB) && innerRight.opr == SUB && innerRight.left == nil) {
            Operator newopr = (self.opr + 1) % 2;
            return [[ArithmeticExpression alloc] init:self.left opr:newopr right:innerRight.right];
        }
    }
    
    // Merge PowerFunction
    if([self.left isKindOfClass:[PowerExpression class]] && [self.right isKindOfClass:[PowerExpression class]] && self.opr == MUL) {
        PowerExpression* leftPower = (PowerExpression*)self.left;
        PowerExpression* rightPower = (PowerExpression*)self.right;
        if([[leftPower base] equals:[rightPower base]]) {
            Number* newpower = (Number*)[leftPower.power add:rightPower.power];
            return [[PowerExpression alloc] init:leftPower.base power:newpower];
        }
    }
    
    // Merge ExpPowerFunction
    if([self.left isKindOfClass:[ExpPowerExpression class]] && [self.right isKindOfClass:[ExpPowerExpression class]] && self.opr == MUL) {
        ExpPowerExpression* leftPower = (ExpPowerExpression*)self.left;
        ExpPowerExpression* rightPower = (ExpPowerExpression*)self.right;
        Expression* newpower = [[[ArithmeticExpression alloc] init:leftPower.power opr:ADD right:rightPower.power] evaluate];
        return [[ExpPowerExpression alloc] init:newpower];
    }
    
    return self;
}


-(Expression*) differentiate:(Variable *)variable {
    if([self.left isKindOfClass:[Data class]] && self.opr == MUL) {
        return [[ArithmeticExpression alloc] init:self.left opr:MUL right:[self.right differentiate:variable]];
    }
    Expression* du = (self.left == nil)? nil: [[self left] differentiate:variable];
    Expression* dv = [[self right] differentiate:variable];
    Expression* result = nil;
    Expression* udv = nil, *vdu = nil,*vv = nil;
    if([self opr] >= MUL) {
        udv = [[ArithmeticExpression alloc] init:[self left] opr:MUL right:dv];
        vdu = [[ArithmeticExpression alloc] init:[self right] opr:MUL right:du];
        vv = [[PowerExpression alloc] init:self.right power:[Integer construct:2]];
    }
    switch([self opr]) {
        case ADD:
        case SUB:
            // du +/- dv
            result = [[ArithmeticExpression alloc] init:du opr:[self opr] right:dv];
            break;
        case MUL:
            // udv + vdu
            result = [[ArithmeticExpression alloc] init:udv opr:ADD right:vdu];
            break;
        case DIV:
            // (vdu - udv)/v²
            result = [[ArithmeticExpression alloc] init:[[ArithmeticExpression alloc] init:vdu opr:SUB right:udv] opr:DIV right:vv];
            break;
        default:
            return nil;
    }
    return result;
}

-(Expression*) integrate:(Variable *)variable {
    Expression* iu = (self.left == nil)? nil:[self.left integrate:variable];
    Expression* iv = [self.right integrate:variable];
    if((self.left != nil && iu == nil) || iv == nil)
        return nil;
    switch (self.opr) {
        case ADD:
            return [[ArithmeticExpression alloc] init:iu opr:ADD right:iv];
        case SUB:
            return [[ArithmeticExpression alloc] init:iu opr:SUB right:iv];
        case MUL: {
            // Try to convert to polynomial
            Expression* poly = [PolynomialExpression toPolynomial:self];
            if(poly != nil && [poly isKindOfClass:[PolynomialExpression class]]) {
                return [poly integrate:variable];
            }
            // TODO For non-polynomials, not implemented
            return nil;
        }
        case DIV: {
            // Try to convert to polynomial
            Expression* poly = [PolynomialExpression toPolynomial:self];
            if(poly != nil && [poly isKindOfClass:[PolynomialExpression class]]) {
                return [poly integrate:variable];
            }
            if([poly isKindOfClass:[ArithmeticExpression class]] && ((ArithmeticExpression*)poly).opr == DIV) {
                ArithmeticExpression* polyedArith = (ArithmeticExpression*)poly;
                if(![polyedArith.left isKindOfClass:[PolynomialExpression class]] || ![polyedArith.right isKindOfClass:[PolynomialExpression class]])
                    return nil;
                PolynomialExpression* leftp = (PolynomialExpression*)polyedArith.left;
                PolynomialExpression* rightp = (PolynomialExpression*)polyedArith.right;
                
                PolynomialExpression* div = [leftp div:rightp];
                PolynomialExpression* mod = [leftp mod:rightp];
                if([mod evaluate] == [Integer ZERO]) {
                    // Fully Division
                    return [div integrate:variable];
                } else if([div evaluate] == [Integer ZERO] && [rightp order] == 1) {
                    // 1/x format, ln result
                    // c/(ax+b)
                    Data* coe = [[mod getCoefficient:0] div:[rightp getCoefficient:1]];
                    Expression* lnf = [[BasicFuncExpression alloc] init:BT_LN base:rightp];
                    return [[ArithmeticExpression alloc] init:coe opr:MUL right:lnf];
                } else if([rightp order] == 1) {
                    Expression* divi = [div integrate:variable];
                    Expression* modi = [[[ArithmeticExpression alloc] init:mod opr:DIV right:rightp] integrate:variable];
                    return [[ArithmeticExpression alloc] init:divi opr:ADD right:modi];
                } else {
                    return nil;
                }
            }
        }
        default:
            return nil;
    }
}

-(NSString*) description {
    NSMutableString* result = [[NSMutableString alloc] initWithCapacity:20];
    if(self.left != nil) {
        if([self.left isKindOfClass:[ArithmeticExpression class]]) {
            ArithmeticExpression* lefta = (ArithmeticExpression*)self.left;
            if(lefta.opr < 3 && self.opr >= 3) {
                [result appendFormat:@"(%@)",[self.left description]];
            } else {
                [result appendString:[self.left description]];
            }
        } else if([self.left isKindOfClass:[PolynomialExpression class]] && [[(PolynomialExpression*)self.left coefficients] count] > 1 && self.opr >= 3){
            [result appendFormat:@"(%@)",[self.left description]];
        } else if([self.left isKindOfClass:[Number class]]) {
            Number* nc = (Number*)self.left;
            if(![nc isKindOfClass:[Integer class]] && self.opr == MUL) {
                [result appendFormat:@"(%@)",[self.left description]];
            } else {
                [result appendString:[self.left description]];
            }
        } else {
            [result appendString:[self.left description]];
        }
    }
    if(!([self.left isKindOfClass:[Data class]] && self.opr == MUL)) {
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
    if([self.right isKindOfClass:[ArithmeticExpression class]]) {
        ArithmeticExpression* righta = (ArithmeticExpression*)self.right;
        if(righta.opr < 3 && self.opr >= 2) {
            [result appendFormat:@"(%@)",[self.right description]];
        } else {
            [result appendString:[self.right description]];
        }
    } else if([self.right isKindOfClass:[PolynomialExpression class]] && [(PolynomialExpression*)self.right validCount] > 1){
        [result appendFormat:@"(%@)",[self.right description]];
    } else {
        [result appendString:[self.right description]];
    }
    
    return result;
}


@end
