//
//  Cleaner.m
//  Calculus
//
//  Created by Harper Jiang on 11/7/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Cleaner.h"
#import "IntegerConstant.h"
#import "PowerFunction.h"
#import "ArithmeticFunction.h"

@implementation Cleaner

+(Function*) clean:(Function *)input {
    IntegerConstant* ZERO = [IntegerConstant ZERO];
    IntegerConstant* ONE = [IntegerConstant ONE];
    // Arithmetic Function
    if([input class] == [ArithmeticFunction class]) {
        ArithmeticFunction* arith = (ArithmeticFunction*)input;
        
        // Calculate constant result if possible
        if([[arith left] class] == [Constant class] && [[arith right] class] == [Constant class]) {
            switch ([arith operator]) {
                case ADD:
                    return [(Constant*)[arith left] add:(Constant*)[arith right]];
                case SUB:
                    return [(Constant*)[arith left] sub:(Constant*)[arith right]];
                case MUL:
                    return [(Constant*)[arith left] mul:(Constant*)[arith right]];
                case DIV:
                    return [(Constant*)[arith left] div:(Constant*)[arith right]];
                default:
                    return nil;
            }
        }
        // Switch Constant and Functions
        if([[arith left] class] != [Constant class] && [[arith right] class] == [Constant class]) {
            // switch Left and right
            return [Cleaner clean:[[ArithmeticFunction alloc] init:[arith right] operator:[arith operator] right:[arith left]]];
        }
        // If MUL/DIV with ZERO/ONE
        if([[arith left] class] == [Constant class]) {
            Constant* cleft = (Constant*)[arith left];
            if([arith operator] == MUL && cleft == ZERO)
                return ZERO;
            if([arith operator] == MUL && cleft == ONE)
                return [arith right];
            if([arith operator] == ADD && cleft == ZERO)
                return [arith right];
        }
        // Merge a*//(b*//x) a+/-(b+/-x)
        if([[arith right] class] == [ArithmeticFunction class]) {
            ArithmeticFunction* innerRight = (ArithmeticFunction*)[arith right];
            if([innerRight operator] / 3 == [arith operator] / 3 && [[innerRight left] class] == [Constant class]) {
                Function* newLeft = [[ArithmeticFunction alloc] init:[arith left] operator:[arith operator] right:[innerRight left]];
                Function* newRight = [innerRight right];
                Operator oldopr1 = [arith operator];
                Operator oldopr2 = [innerRight operator];
                Operator newopr = 0;
                if(oldopr1/3 == 0) {
                    newopr = ((oldopr1 + oldopr2)%2 == 0)?ADD:SUB;
                } else {
                    newopr = ((oldopr1 + oldopr2)%2 == 0)?MUL:DIV;
                }
                return [[ArithmeticFunction alloc] init:newLeft operator:newopr right:newRight];
            }
        }
        
    }
    // PowerFunction
    if([input class] == [PowerFunction class]) {
        // Check whether the power is zero
        if([(PowerFunction*)input power] == ZERO)
            return ONE;
    }
    
    return input;
}

@end
