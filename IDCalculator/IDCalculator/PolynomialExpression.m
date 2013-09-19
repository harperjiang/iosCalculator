//
//  PolynomialExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/12/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "PolynomialExpression.h"
#import "PowerExpression.h"
#import "ArithmeticExpression.h"
#import "SpecialConstant.h"
#import "RealNumber.h"
#import "Decimal.h"
#import "Integer.h"
#include "math.h"

@implementation PolynomialExpression {
    NSInteger _validCount;
}

-(PolynomialExpression *)init {
    self = [super init];
    if(self){
        self.coefficients = [[NSMutableArray alloc] initWithCapacity:10];
        self.variable = [Variable x];
    }
    return self;
}

-(Expression *)differentiate:(Variable *)variable {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    for(NSInteger count = [self.coefficients count] -1 ; count > 0 ; count--) {
        [pf addItem: [(Data*)[[self coefficients] objectAtIndex:count] mul: [Integer construct: count]] power:count -1];
    }
    return pf;
}

-(Expression *)integrate:(Variable *)variable {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    
    for(NSInteger i = [self.coefficients count] -1 ; i >=0 ; i--) {
        Number* mycoe = [self.coefficients objectAtIndex:i];
        Number* newc = (Number*)[mycoe div:[Integer construct:i+1]];
        [pf addItem:newc power:i+1];
    }
    return pf;
}

-(void)addItem:(Number *)coefficient power:(NSInteger)power {
    Number* oldco = nil;
    Number* newco = nil;
    while([self.coefficients count] <= power)
        [self.coefficients addObject:[Integer ZERO]];
    oldco = [self.coefficients objectAtIndex:power];
    if(oldco == nil) {
        newco = coefficient;
    } else {
        newco = (Number*)[oldco add:coefficient];
    }
    int oldval = (oldco == nil || oldco == [Integer ZERO])?0:1;
    int newval = (newco == nil || newco == [Integer ZERO])?0:1;
    [self.coefficients setObject:newco atIndexedSubscript:power];
    self->_validCount += newval - oldval;
}

+(PolynomialExpression *)toPolynomial:(Expression *)func {
    return [PolynomialExpression toPolynomial:func under:[Variable x]];
}

+(Expression*) toPolynomial:(Expression*) function under:(Variable *)var{
    if([function isKindOfClass:[Variable class]]) {
        Variable* v = (Variable*) function;
        if([v.name isEqualToString:[Variable x].name]) {
            PolynomialExpression* poly = [[PolynomialExpression alloc] init];
            poly.variable = (Variable*)function;
            [poly addItem:[Integer ONE] power:1];
            return poly;
        } else {
            return nil;
        }
    }
    if([function isKindOfClass:[PowerExpression class]]) {
        PowerExpression* pf = (PowerExpression*)function;
        if([pf.power isKindOfClass:[Integer class]]) {
            Expression* inner = [PolynomialExpression toPolynomial:[pf base]];
            if(nil != inner && [inner isKindOfClass:[PolynomialExpression class]]) {
                inner = [(PolynomialExpression*)inner power: pf.power];
                return inner;
            }
        }
        return function;
    }
    if([function isKindOfClass:[Number class]] || [function isKindOfClass:[Constant class]]) {
        PolynomialExpression* poly = [[PolynomialExpression alloc] init];
        [poly addItem:(Data*)function power:0];
        return poly;
    }
    if([function isKindOfClass:[ArithmeticExpression class]]) {
        ArithmeticExpression* arith = (ArithmeticExpression*)function;
        
        Expression* leftp = [PolynomialExpression toPolynomial:arith.left];
        Expression* rightp = [PolynomialExpression toPolynomial:arith.right];
        
        if(leftp == nil || rightp == nil)
            return function;
        Boolean bothpoly = [leftp isKindOfClass:[PolynomialExpression class]] && [rightp isKindOfClass:[PolynomialExpression class]];
        
        switch(arith.opr) {
            case ADD:
                if(bothpoly) {
                    return [(PolynomialExpression*)leftp add:(PolynomialExpression*)rightp];
                } else {
                    return [[ArithmeticExpression alloc] init:leftp opr:ADD right:rightp];
                }
            case SUB:
                if(bothpoly) {
                    return [(PolynomialExpression*)leftp sub:(PolynomialExpression*)rightp];
                } else {
                    return [[ArithmeticExpression alloc] init:leftp opr:SUB right:rightp];
                }
            case MUL:
                if(bothpoly) {
                    return [(PolynomialExpression*)leftp mul:(PolynomialExpression*)rightp];
                } else {
                    return [[ArithmeticExpression alloc] init:leftp opr:MUL right:rightp];
                }
            case DIV:
                return [[ArithmeticExpression alloc] init:leftp opr:DIV right:rightp];
            default:
                return nil;
        }
    }
    if([function isKindOfClass:[PolynomialExpression class]]) {
        return function;
    }
    return nil;
}

-(Expression*) evaluate {
    // Remove all higher order empty coefficients
    for(NSInteger count = [self.coefficients count] - 1 ; count >=0 ; count--) {
        if([self.coefficients objectAtIndex:count] == [Integer ZERO]) {
            [self.coefficients removeObjectAtIndex:count];
        } else {
            break;
        }
    }
    // Return constant if is constant
    if([self.coefficients count] == 1)
        return [self.coefficients objectAtIndex:0];
    if([self.coefficients count] == 0)
        return [Integer ZERO];
    // Calculate the value if the variable is assigned a value
    Expression* var = [[self variable] evaluate];
    if([var isKindOfClass:[RealNumber class]]) {
        RealNumber* value = (RealNumber*)var;
        Data* sum = [Integer ZERO];
        for(NSInteger i = 0 ; i < [[self coefficients] count];i++) {
            Decimal* exp = [[Decimal alloc] init: [[NSDecimalNumber alloc] initWithDouble: pow([[value toDecimal].value doubleValue],i)]];
            sum = [sum add:[exp mul:(Data*)[[self coefficients] objectAtIndex:i]]];
        }
        return sum;
    } else {
        return self;
    }
}

-(NSString*) description {
    if([self.coefficients count] == 0)
        return [[Integer ZERO] description];
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:20];
    for(NSInteger count = [self.coefficients count] -1 ; count >= 0 ; count--) {
        Data* coefficient = (Data*)[self.coefficients objectAtIndex:count];
        if(coefficient != nil && coefficient != [Integer ZERO]) {
            if(count == [self.coefficients count]-1 && count !=0) {
                // Highest Order Sign
                if([coefficient isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)coefficient;
                    if(coefficient == [Integer NEGAONE])
                        [buffer appendString:@"-"];
                    else if(coval.value > 0)
                        [buffer appendString:@""];
                } else {
                    [buffer appendString:@""];
                }
            } else if(count > 0){
                // Middle Part Sign
                if([coefficient isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)coefficient;
                    if(coefficient == [Integer NEGAONE])
                        [buffer appendString:@"-"];
                    else if(coval.value > 0)
                        [buffer appendString:@"+"];
                } else {
                    [buffer appendString:@"+"];
                }
            } else if(count==0 && [self.coefficients count] != 1){
                // Constant Sign
                if([coefficient isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)coefficient;
                    if(coefficient == [Integer NEGAONE])
                        [buffer appendString:@""];
                    else if(coval.value > 0)
                        [buffer appendString:@"+"];
                } else {
                    [buffer appendString:@"+"];
                }
            }
            // Judge whether we need parenthesis
            if([coefficient isKindOfClass:[Number class]]) {
                Number* ncco = (Number*)coefficient;
                if([ncco isKindOfClass:[Integer class]]) {
                    if(!((ncco == [Integer ONE] || ncco == [Integer NEGAONE]) && count != 0))
                        [buffer appendString: [coefficient description]];
                } else {
                    [buffer appendFormat:@"(%@)", [coefficient description]];
                }
            } else if([coefficient isKindOfClass:[SpecialConstant class]]) {
                [buffer appendFormat:@"%@",[coefficient description]];
            } else {
                [buffer appendFormat:@"(%@)", [coefficient description]];
            }
            if(count !=0)
                [buffer appendString:[self.variable description]];
            [buffer appendString:[PowerExpression stringForPower:[Integer construct:count]]];
            
        }
    }
    return buffer;
}

-(PolynomialExpression *)power:(Data *)power {
    if([power isKindOfClass:[Number class]]) {
        Number* ncpower = (Number*)power;
        PolynomialExpression* current = self;
        if([ncpower isKindOfClass:[Integer class]]) {
            NSInteger powerval = [(Integer*) ncpower value];
            for(int i = 1 ; i < powerval ; i ++)
                current = [current mul:self];
            return current;
        }
    }
    return nil;
}

-(Data *)getCoefficient:(NSInteger)power {
    if(power >= [self.coefficients count])
        return [Integer ZERO];
    Data* val = (Data*)[self.coefficients objectAtIndex: power];
    if(nil == val)
        return [Integer ZERO];
    return val;
}

-(NSInteger)order {
    for(int i = [[self coefficients] count] - 1 ; i >= 0 ; i--) {
        if([self.coefficients objectAtIndex:i] == [Integer ZERO]) {
            [self.coefficients removeObjectAtIndex:i];
        } else {
            return i;
        }
    }
    return 0;
}

-(PolynomialExpression*) add:(PolynomialExpression *)another {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    NSInteger max = MAX([self.coefficients count],[another.coefficients count]);
    for(int power = 0 ; power < max ; power++) {
        Data* me = [self getCoefficient:power];
        Data* it = [another getCoefficient:power];
        Data* newone = [me add:it];
        [pf addItem:newone power:power];
    }
    return pf;
}

-(PolynomialExpression*) sub:(PolynomialExpression *)another {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    NSInteger max = MAX([self.coefficients count],[another.coefficients count]);
    for(int power = 0 ; power < max ; power++) {
        Data* me = [self getCoefficient:power];
        Data* it = [another getCoefficient:power];
        Data* newone = [me sub:it];
        [pf addItem:newone power:power];
    }
    return pf;
}

-(PolynomialExpression*) mul:(PolynomialExpression *)another {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    
    for(int mypower = 0 ; mypower < [self.coefficients count] ; mypower++) {
        for(int hispower = 0 ; hispower < [another.coefficients count] ; hispower++) {
            Data* me = [self getCoefficient:mypower];
            Data* it = [another getCoefficient:hispower];
            Data* newone = [me mul:it];
            [pf addItem:newone power:mypower+hispower];
        }
    }
    return pf;
}

-(PolynomialExpression *)div:(PolynomialExpression *)another {
    PolynomialExpression* pf = [[PolynomialExpression alloc] init];
    if([another order] > [self order]) {
        [pf addItem:[Integer ZERO] power:0];
    } else {
        PolynomialExpression* remain = self;
        while([remain order] >= [another order]) {
            Data* mul = [[remain getCoefficient:[remain order]] div:[another getCoefficient:[another order]]];
            PolynomialExpression* val = [[PolynomialExpression alloc] init];
            [val addItem:mul power:[remain order] - [another order]];
            pf = [pf add:val];
            remain = [remain sub:[another mul:val]];
        }
    }
    return pf;
}

-(PolynomialExpression *)mod:(PolynomialExpression *)another {
    if([another order] > [self order]) {
        return self;
    } else {
        PolynomialExpression* remain = self;
        while([remain order] >= [another order]) {
            Data* mul = [[remain getCoefficient:[remain order]] div:[another getCoefficient:[another order]]];
            PolynomialExpression* val = [[PolynomialExpression alloc] init];
            [val addItem:mul power:[remain order] - [another order]];
            remain = [remain sub:[another mul:val]];
        }
        return remain;
    }
}

-(NSInteger) validCount {
    if(self->_validCount == -1) {
        self->_validCount = 0;
        for(int i = 0 ; i < [self.coefficients count]; i++) {
            Data* con = [self.coefficients objectAtIndex:i];
            if(!(con == nil || con == [Integer ZERO])) {
                self->_validCount += 1;
            }
        }
    }
    return self->_validCount;
}

@end

