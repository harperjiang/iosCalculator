//
//  PolynomialFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/4/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PolynomialFunction.h"
#import "Variable.h"
#import "PowerFunction.h"
#import "Integer.h"
#import "SpecialConstant.h"
#import "ArithmeticFunction.h"

@implementation PolynomialFunction {
    NSInteger _validCount;
}

-(PolynomialFunction *)init {
    self = [super init];
    if(self){
        self.coefficients = [[NSMutableArray alloc] initWithCapacity:10];
        self.variable = [Variable x];
    }
    return self;
}

-(Function *)differentiate:(Variable *)variable {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    for(NSInteger count = [self.coefficients count] -1 ; count > 0 ; count--) {
        [pf addItem:[[self.coefficients objectAtIndex:count] mul: [NumConstant constructWithInteger:count] ] power:count -1];
    }
    return pf;
}

-(Function *)integrate:(Variable *)variable {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    
    for(NSInteger i = [self.coefficients count] -1 ; i >=0 ; i--) {
        Constant* mycoe = [self.coefficients objectAtIndex:i];
        Constant* newc = [mycoe div:[NumConstant constructWithInteger:i+1]];
        [pf addItem:newc power:i+1];
    }
    return pf;
}

-(void)addItem:(Constant *)coefficient power:(NSInteger)power {
    Constant* oldco = nil;
    Constant* newco = nil;
    while([self.coefficients count] <= power)
        [self.coefficients addObject:[NumConstant ZERO]];
    oldco = [self.coefficients objectAtIndex:power];
    if(oldco == nil) {
        newco = coefficient;
    } else {
        newco = [oldco add:coefficient];
    }
    int oldval = (oldco == nil || oldco == [NumConstant ZERO])?0:1;
    int newval = (newco == nil || newco == [NumConstant ZERO])?0:1;
    [self.coefficients setObject:newco atIndexedSubscript:power];
    self->_validCount += newval - oldval;
}

+(Function*) toPolynomial:(Function*) function {
    if([function isKindOfClass:[Variable class]]) {
        PolynomialFunction* poly = [[PolynomialFunction alloc] init];
        poly.variable = (Variable*)function;
        [poly addItem:[NumConstant ONE] power:1];
        return poly;
    }
    if([function isKindOfClass:[PowerFunction class]]) {
        PowerFunction* pf = (PowerFunction*)function;
        if([pf.power isKindOfClass:[NumConstant class]] && [((NumConstant*)pf.power).number isKindOfClass:[Integer class]]) {
            Function* inner = [PolynomialFunction toPolynomial:[pf base]];
            if(nil != inner && [inner isKindOfClass:[PolynomialFunction class]]) {
                inner = [(PolynomialFunction*)inner power: pf.power];
                return inner;
            }
        }
        return function;
    }
    if([function isKindOfClass:[Constant class]]) {
        PolynomialFunction* poly = [[PolynomialFunction alloc] init];
        [poly addItem:(Constant*)function power:0];
        return poly;
    }
    if([function isKindOfClass:[ArithmeticFunction class]]) {
        ArithmeticFunction* arith = (ArithmeticFunction*)function;
        
        Function* leftp = [PolynomialFunction toPolynomial:arith.left];
        Function* rightp = [PolynomialFunction toPolynomial:arith.right];
        
        if(leftp == nil || rightp == nil)
            return function;
        Boolean bothpoly = [leftp isKindOfClass:[PolynomialFunction class]] && [rightp isKindOfClass:[PolynomialFunction class]];
        
        switch(arith.opr) {
            case ADD:
                if(bothpoly) {
                    return [(PolynomialFunction*)leftp add:(PolynomialFunction*)rightp];
                } else {
                    return [[ArithmeticFunction alloc] init:leftp opr:ADD right:rightp];
                }
            case SUB:
                if(bothpoly) {
                    return [(PolynomialFunction*)leftp sub:(PolynomialFunction*)rightp];
                } else {
                    return [[ArithmeticFunction alloc] init:leftp opr:SUB right:rightp];
                }
            case MUL:
                if(bothpoly) {
                    return [(PolynomialFunction*)leftp mul:(PolynomialFunction*)rightp];
                } else {
                    return [[ArithmeticFunction alloc] init:leftp opr:MUL right:rightp];
                }
            case DIV:
                return [[ArithmeticFunction alloc] init:leftp opr:DIV right:rightp];
            default:
                return nil;
        }
    }
    return nil;
}

-(Function*) evaluate {
    // Remove all higher order empty coefficients
    for(NSInteger count = [self.coefficients count] - 1 ; count >=0 ; count--) {
        if([self.coefficients objectAtIndex:count] == [NumConstant ZERO]) {
            [self.coefficients removeObjectAtIndex:count];
        } else {
            break;
        }
    }
    // Return constant if is constant
    if([self.coefficients count] == 1)
        return [self.coefficients objectAtIndex:0];
    if([self.coefficients count] == 0)
        return [NumConstant ZERO];
    return self;
}

-(NSString*) description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:20];
    for(NSInteger count = [self.coefficients count] -1 ; count >= 0 ; count--) {
        Constant* coefficient = (Constant*)[self.coefficients objectAtIndex:count];
        if(coefficient != nil && coefficient != [NumConstant ZERO]) {
            if(count == [self.coefficients count]-1 && count !=0) {
                // Highest Order Sign
                if([coefficient isKindOfClass:[NumConstant class]] && [[(NumConstant*)coefficient number] isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)[(NumConstant*)coefficient number];
                    if(coefficient == [NumConstant NEGAONE])
                        [buffer appendString:@"-"];
                    else if(coval.value > 0)
                        [buffer appendString:@""];
                } else {
                    [buffer appendString:@""];
                }
            } else if(count > 0){
                // Middle Part Sign
                if([coefficient isKindOfClass:[NumConstant class]] && [[(NumConstant*)coefficient number] isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)[(NumConstant*)coefficient number];
                    if(coefficient == [NumConstant NEGAONE])
                        [buffer appendString:@"-"];
                    else if(coval.value > 0)
                        [buffer appendString:@"+"];
                } else {
                    [buffer appendString:@"+"];
                }
            } else if(count==0 && [self.coefficients count] != 1){
                // Constant Sign
                if([coefficient isKindOfClass:[NumConstant class]] && [[(NumConstant*)coefficient number] isKindOfClass:[Integer class]]) {
                    Integer* coval = (Integer*)[(NumConstant*)coefficient number];
                    if(coefficient == [NumConstant NEGAONE])
                        [buffer appendString:@""];
                    else if(coval.value > 0)
                        [buffer appendString:@"+"];
                } else {
                    [buffer appendString:@"+"];
                }
            }
            // Judge whether we need parenthesis
            if([coefficient isKindOfClass:[NumConstant class]]) {
                NumConstant* ncco = (NumConstant*)coefficient;
                if([ncco.number isKindOfClass:[Integer class]]) {
                    if(!((ncco == [NumConstant ONE] || ncco == [NumConstant NEGAONE]) && count != 0))
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
            [buffer appendString:[PowerFunction stringForPower:[NumConstant construct:[Integer construct:count]]]];
            
        }
    }
    return buffer;
}

-(PolynomialFunction *)power:(Constant *)power {
    if([power isKindOfClass:[NumConstant class]]) {
        NumConstant* ncpower = (NumConstant*)power;
        PolynomialFunction* current = self;
        if([ncpower.number isKindOfClass:[Integer class]]) {
            NSInteger powerval = [(Integer*) ncpower.number value];
            for(int i = 1 ; i < powerval ; i ++)
                current = [current mul:self];
            return current;
        }
    }
    return nil;
}

-(Constant *)getCoefficient:(NSInteger)power {
    if(power >= [self.coefficients count])
        return [NumConstant ZERO];
    Constant* val = (Constant*)[self.coefficients objectAtIndex: power];
    if(nil == val)
        return [NumConstant ZERO];
    return val;
}

-(PolynomialFunction*) add:(PolynomialFunction *)another {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    NSInteger max = MAX([self.coefficients count],[another.coefficients count]);
    for(int power = 0 ; power < max ; power++) {
        Constant* me = [self getCoefficient:power];
        Constant* it = [another getCoefficient:power];
        Constant* newone = [me add:it];
        [pf addItem:newone power:power];
    }
    return pf;
}

-(PolynomialFunction*) sub:(PolynomialFunction *)another {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    NSInteger max = MAX([self.coefficients count],[another.coefficients count]);
    for(int power = 0 ; power < max ; power++) {
        Constant* me = [self getCoefficient:power];
        Constant* it = [another getCoefficient:power];
        Constant* newone = [me sub:it];
        [pf addItem:newone power:power];
    }
    return pf;
}

-(PolynomialFunction*) mul:(PolynomialFunction *)another {
    PolynomialFunction* pf = [[PolynomialFunction alloc] init];
    
    for(int mypower = 0 ; mypower < [self.coefficients count] ; mypower++) {
        for(int hispower = 0 ; hispower < [another.coefficients count] ; hispower++) {
            Constant* me = [self getCoefficient:mypower];
            Constant* it = [another getCoefficient:hispower];
            Constant* newone = [me mul:it];
            [pf addItem:newone power:mypower+hispower];
        }
    }
    return pf;
}

-(NSInteger) validCount {
    if(self->_validCount == -1) {
        self->_validCount = 0;
        for(int i = 0 ; i < [self.coefficients count]; i++) {
            Constant* con = [self.coefficients objectAtIndex:i];
            if(!(con == nil || con == [NumConstant ZERO])) {
                self->_validCount += 1;
            }
        }
    }
    return self->_validCount;
}

@end
