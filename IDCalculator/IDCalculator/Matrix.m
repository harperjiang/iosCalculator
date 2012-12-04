//
//  Matrix.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Matrix.h"
#import "SquareMatrix.h"
#import "Vector.h"
#import "Integer.h"
#import "NumberData.h"
#import "Number.h"
#import "ExpressionList.h"

#import "IDCConsole.h"

@implementation Matrix

+(Matrix *)identity:(NSInteger)num {
    ExpressionList* data = [[ExpressionList alloc] init];
    for(int i = 0 ; i < num ; i++) {
        ExpressionList* row = [[ExpressionList alloc] init];
        for(int j = 0 ; j < num ; j ++) {
            if(j==i)
                [row add:[[NumberData alloc] init:[Integer ONE]]];
            else
                [row add:[[NumberData alloc] init:[Integer ZERO]]];
        }
        [data add:row];
    }
    return [[Matrix alloc]init:data];
}

-(Matrix*) init:(NSArray*)d m:(NSInteger) row n:(NSInteger)col {
    self = [super init];
    if(self) {
        self->_m = row;
        self->_n = col;
        if([d count] != row*col) {
            NSLog(@"Not enough values");
            return nil;
        }
        ExpressionList* data = [[ExpressionList alloc] init];
        for(NSInteger i = 0 ; i < [self m] ; i++) {
            ExpressionList* row = [[ExpressionList alloc] init];
            for(NSInteger j = 0 ; j < [self n]; j++) {
                Number* number = (Number*)[d objectAtIndex:i*[self n]+j];
                Expression* exp = [[NumberData alloc] init:number];
                [row add:exp];
            }
            [data add:row];
        }
        [self setData:data];
    }
    return self;
}

-(Matrix*) init:(ExpressionList*)data {
    self = [super init];
    if(self) {
        int colcount = 0;
        if([data count] == 0) {
            self->_data=data;
            self->_m=0;
            self->_n=0;
        } else {
            for(NSInteger i = 0 ; i < [data count] ; i++) {
                ExpressionList* row = (ExpressionList*)[data get:i];
                if(colcount == 0) {
                    colcount = [row count];
                } else if(colcount != [row count ]) {
                    [[IDCConsole instance] error:@"Wrong column count in matrix row"];
                    return nil;
                }
            }
            [self setData:data];
            self->_m = [data count];
            self->_n = [(ExpressionList*)[data get:0] count];
        }
    }
    return self;
}

-(Data*) evaluate {
    // Convert Expression to value
    for(int i = 0 ; i < [self.data count] ; i++) {
        ExpressionList* row = (ExpressionList*)[self.data get:i];
        for(int j = 0 ; j < [row count] ; j++) {
            Expression* exp = [row get:j];
            if(![exp isKindOfClass:[Data class]]) {
                Data* value = [exp evaluate];
                if(![value isKindOfClass:[NumberData class]]){
                    [self error:@"Matrix can only contain number data"];
                    return nil;
                }
                [row set:j value:value];
            }
        }
    }
    return self;
}

-(Data*) add:(Data*) another {
    if([another class] == [Matrix class]) {
        Matrix* anotherM = (Matrix*)another;
        if([self m] != [anotherM m] || [self n] != [anotherM n]) {
            [self error:@"Adding matrices with different size"];
            return nil;
        }
        ExpressionList* newdata = [[ExpressionList alloc] init];
        for(int i = 0 ; i < [self m] ; i++) {
            ExpressionList* newrow = [[ExpressionList alloc] init];
            for(int j = 0 ; j < [self n]; j++) {
                Number* sum = [[self val:i n:j] add:[anotherM val:i n:j]];
                [newrow add:[[NumberData alloc] init:sum]];
            }
            [newdata add:newrow];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [self error:@"Adding Matrix to non-Matrix"];
        return nil;
    }
}


-(Data*) sub:(Data*) another {
    if([another class] == [Matrix class]) {
        Matrix* anotherM = (Matrix*)another;
        if([self m] != [anotherM m] || [self n] != [anotherM n]) {
            [self error:@"Adding matrices with different size"];
            return nil;
        }
        ExpressionList* newdata = [[ExpressionList alloc] init];
        for(int i = 0 ; i < [self m] ; i++) {
            ExpressionList* newrow = [[ExpressionList alloc] init];
            for(int j = 0 ; j < [self n]; j++) {
                Number* sum = [[self val:i n:j] sub:[anotherM val:i n:j]];
                [newrow add:[[NumberData alloc] init:sum]];
            }
            [newdata add:newrow];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [self error:@"Adding Matrix to non-Matrix"];
        return nil;
    }
}

-(Data*) mul:(Data *)another {
    if([another class] == [Matrix class] || [another class] == [SquareMatrix class] || [another class] == [Vector class]) {
        Matrix* am = (Matrix*) another;
        if([am m] == [self n]) {
            // n cube speed
            ExpressionList* data = [[ExpressionList alloc] init];
            for (int i = 0 ; i < [self m]; i++) {
                ExpressionList* row = [[ExpressionList alloc] init];
                for(int j = 0 ; j < [am n]; j++) {
                    Number* sum = [Integer ZERO];
                    for(int k = 0 ; k < [self n] ; k++) {
                        sum = [sum add: [[self val:i n:k] mul:[am val:k n:j]]];
                    }
                    [row add:[[NumberData alloc] init:sum]];
                }
                [data add:row];
            }
            return [[Matrix alloc] init:data];
        } else {
            [self error:@"Multiplying Matrices with wrong size"];
            return nil;
        }
    } else if([another class] == [NumberData class]){
        // Mul with number
        NumberData* nd = (NumberData*)another;
        ExpressionList* newdata = [[ExpressionList alloc] init];
        for(int i = 0;i< [self m];i++) {
            ExpressionList* row = [[ExpressionList alloc] init];
            for(int j = 0 ; j < [self n];j++) {
                Number* val = [self val:i n:j];
                Number* mulresult = [[nd number] mul:val];
                [row add:[[NumberData alloc] init:mulresult]];
            }
            [newdata add:row];
        }
        return [[Matrix alloc] init:newdata];
    }
    return nil;
}

-(Data*) div:(Data*) another {
    if([another class] == [NumberData class]) {
        // Mul with number
        NumberData* nd = (NumberData*)another;
        ExpressionList* newdata = [[ExpressionList alloc] init];
        for(int i = 0;i< [self m];i++) {
            ExpressionList* row = [[ExpressionList alloc] init];
            for(int j = 0 ; j < [self n];j++) {
                Number* val = [self val:i n:j];
                Number* divresult = [val div:[nd number]];
                [row add:[[NumberData alloc] init:divresult]];
            }
            [newdata add:row];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [self error:@"Matrix can only be divided by number"];
        return nil;
    }
}

-(Number*) val:(NSInteger) i n:(NSInteger)j {
    ExpressionList* row = (ExpressionList*)[[self data] get:i];
    Expression* item = [row get:j];
    assert([item class] == [NumberData class]);
    return [(NumberData*)item number];
}

-(void)setVal:(NSInteger)i n:(NSInteger)j val:(Number *)value {
    // Append Expressions
    while(i >= [[self data] count]) {
        ExpressionList* newrow = [[ExpressionList alloc] init];
        [[self data] add:newrow];
    }
    ExpressionList* row = (ExpressionList*)[[self data] get:i];
    while(j>= [row count]) {
        [row add:[[NumberData alloc] init:nil]];
    }
    [(NumberData*)[row get:j] setNumber:value];
    if(i >= [self m])
        self->_m = i+1;
    if(j >= [self n])
        self->_n = j+1;
}

-(Matrix*) transpose {
    ExpressionList* selfdata = [self data];
    ExpressionList* newdata = [[ExpressionList alloc] init];
    for(int i = 0 ; i < [self n];i++) {
        ExpressionList* row = [[ExpressionList alloc] init];
        for(int j = 0 ; j < [self m]; j++) {
            [row add:[(ExpressionList*)[selfdata get:j] get:i]];
        }
        [newdata add:row];
    }
    return [[Matrix alloc] init:newdata];
}


-(NSString*) description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:[self m]*[self n]];
    for(int i = 0 ; i < [self m] ; i++){
        for(int j = 0 ; j < [self n]; j++) {
            [buffer appendFormat:@"%@\t",[[self val:i n:j] description]];
        }
        [buffer appendString:@"\n"];
    }
    return buffer;
}

-(Matrix *)submatrix:(NSRange)rowrange column:(NSRange)colrange {
    ExpressionList* data = [[ExpressionList alloc] init];
    Matrix* m = [[Matrix alloc] init:data];
    for( int i = 0 ; i < rowrange.length;i++)
        for(int j = 0 ; j < colrange.length ; j++) {
           [m setVal:i n:j val:[self val:rowrange.location +i n:colrange.location+j]];
        }
    return m;
}

-(Matrix*) duplicate {
    return [self submatrix:NSMakeRange(0, [self m]) column:NSMakeRange(0, [self n])];
}

-(NSInteger)rank {
    // TODO
    if([self m] == [self n])
        return [self m];
    return -1;
}

-(Number *)determinant {
    return nil;
}

-(Matrix*) inverse {
    if([self m] == [self n] && [self rank] == [self m]) {
        NSInteger size = [self m];
        Matrix* factor = [Matrix identity:size];
        Matrix* remain = [self duplicate];
        for(NSInteger i = 0 ; i < size ; i++) {
            // For Each Row, make the pivot to be 1
            Matrix* pivot1 = [Matrix identity:size];
            Number* pivotval = [[Integer ONE] div:[remain val:i n:i]];
            [pivot1 setVal:i n:i val:pivotval];
            factor = (Matrix*)[pivot1 mul:factor];
            remain = (Matrix*)[pivot1 mul:remain];
            
            Matrix* reduce = [Matrix identity:size];
            
            for(NSInteger j = 0 ; j < size; j++) {
                if(j != i) {
                    Number* remval = [remain val:j n:i];
                    [reduce setVal:j n:i val: [[Integer ZERO] sub:remval]];
                }
            }
            factor = (Matrix*)[reduce mul:factor];
            remain = (Matrix*)[reduce mul:remain];
        }
        return factor;
    }
    [self error:@"Not a square matrix"];
    return nil;
}

@end
