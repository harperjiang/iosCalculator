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
#import "Number.h"
#import "Log.h"

@implementation Matrix

+(Matrix *)identity:(NSInteger)num {
    NSMutableArray* data = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < num ; i++) {
        NSMutableArray* row = [[NSMutableArray alloc] init];
        for(int j = 0 ; j < num ; j ++) {
            if(j==i)
                [row addObject: [Integer ONE]];
            else
                [row addObject: [Integer ZERO]];
        }
        [data addObject:row];
    }
    return [[Matrix alloc]init:data];
}

-(Matrix*) init:(NSArray*)d m:(NSInteger) row n:(NSInteger)col {
    self = [super init];
    if(self) {
        self->_m = row;
        self->_n = col;
        if([d count] != row*col) {
            [Log error: @"Not enough values"];
            return nil;
        }
        NSMutableArray* data = [[NSMutableArray alloc] init];
        for(NSInteger i = 0 ; i < [self m] ; i++) {
            NSMutableArray* row = [[NSMutableArray alloc] init];
            for(NSInteger j = 0 ; j < [self n]; j++) {
                Number* number = (Number*)[d objectAtIndex:i*[self n]+j];
                [row addObject: number];
            }
            [data addObject:row];
        }
        [self setData:data];
    }
    return self;
}

-(Matrix*) init:(NSMutableArray*)data {
    self = [super init];
    if(self) {
        int colcount = 0;
        if([data count] == 0) {
            self->_data=data;
            self->_m=0;
            self->_n=0;
        } else {
            for(NSInteger i = 0 ; i < [data count] ; i++) {
                NSMutableArray* row = (NSMutableArray*)[data objectAtIndex:i];
                if(colcount == 0) {
                    colcount = [row count];
                } else if(colcount != [row count ]) {
                    [Log error:@"Wrong column count in matrix row"];
                    return nil;
                }
            }
            [self setData:data];
            self->_m = [data count];
            self->_n = [(NSMutableArray*)[data objectAtIndex:0] count];
        }
    }
    return self;
}

-(Matrix*) initWithExpression:(ExpressionList *)data {
    self = [super init];
    if(self) {
        int colcount = 0;
        if([data count] == 0) {
            self->_data= [[NSMutableArray alloc] init];
            self->_m=0;
            self->_n=0;
        } else {
            [self setData:[[NSMutableArray alloc] init]];
            for(NSInteger i = 0 ; i < [data count] ; i++) {
                ExpressionList* inputrow = (ExpressionList*) [data get:i];
                NSMutableArray* row = [[NSMutableArray alloc] init];
                if(colcount == 0) {
                    colcount = [inputrow count];
                } else if(colcount != [inputrow count ]) {
                    [Log error:@"Wrong column count in matrix row"];
                    return nil;
                }
                for(NSInteger j = 0 ; j < [inputrow count]; j++) {
                    [row addObject:[inputrow get:j]];
                }
                [[self data] addObject:row];
            }
            self->_m = [data count];
            self->_n = [(NSMutableArray*)[[self data] objectAtIndex:0] count];
        }
    }
    return self;
}

-(Data*) evaluate {
    // Convert Expression to value
    for(int i = 0 ; i < [self.data count] ; i++) {
        NSMutableArray* row = (NSMutableArray*)[self.data objectAtIndex:i];
        for(int j = 0 ; j < [row count] ; j++) {
            Expression* exp = [row objectAtIndex:j];
            if(![exp isKindOfClass:[Data class]]) {
                Expression* value = [exp evaluate];
                if(![value isKindOfClass:[Number class]]){
                    [Log error:@"Matrix can only contain number data"];
                    return nil;
                }
                [row insertObject:value atIndex:j];
            }
        }
    }
    return self;
}

-(Data*) add:(Data*) another {
    if([another class] == [Matrix class]) {
        Matrix* anotherM = (Matrix*)another;
        if([self m] != [anotherM m] || [self n] != [anotherM n]) {
            [Log error:@"Adding matrices with different size"];
            return nil;
        }
        NSMutableArray* newdata = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < [self m] ; i++) {
            NSMutableArray* newrow = [[NSMutableArray alloc] init];
            for(int j = 0 ; j < [self n]; j++) {
                Data* sum = [[self val:i n:j] add:[anotherM val:i n:j]];
                [newrow addObject: sum];
            }
            [newdata addObject:newrow];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [Log error:@"Adding Matrix to non-Matrix"];
        return nil;
    }
}


-(Data*) sub:(Data*) another {
    if([another class] == [Matrix class]) {
        Matrix* anotherM = (Matrix*)another;
        if([self m] != [anotherM m] || [self n] != [anotherM n]) {
            [Log error:@"Adding matrices with different size"];
            return nil;
        }
        NSMutableArray* newdata = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < [self m] ; i++) {
            NSMutableArray* newrow = [[NSMutableArray alloc] init];
            for(int j = 0 ; j < [self n]; j++) {
                Data* sum = [[self val:i n:j] sub:[anotherM val:i n:j]];
                [newrow addObject:sum ];
            }
            [newdata addObject:newrow];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [Log error:@"Adding Matrix to non-Matrix"];
        return nil;
    }
}

-(Data*) mul:(Data *)another {
    if([another class] == [Matrix class] || [another class] == [SquareMatrix class] || [another class] == [Vector class]) {
        Matrix* am = (Matrix*) another;
        if([am m] == [self n]) {
            // n cube speed
            NSMutableArray* data = [[NSMutableArray alloc] init];
            for (int i = 0 ; i < [self m]; i++) {
                NSMutableArray* row = [[NSMutableArray alloc] init];
                for(int j = 0 ; j < [am n]; j++) {
                    Data* sum = [Integer ZERO];
                    for(int k = 0 ; k < [self n] ; k++) {
                        sum = [sum add: [[self val:i n:k] mul:[am val:k n:j]]];
                    }
                    [row addObject:sum];
                }
                [data addObject:row];
            }
            return [[Matrix alloc] init:data];
        } else {
            [Log error:@"Multiplying Matrices with wrong size"];
            return nil;
        }
    } else if([another class] == [Number class]){
        // Mul with number
        Number* nd = (Number*)another;
        NSMutableArray* newdata = [[NSMutableArray alloc] init];
        for(int i = 0;i< [self m];i++) {
            NSMutableArray* row = [[NSMutableArray alloc] init];
            for(int j = 0 ; j < [self n];j++) {
                Data* val = [self val:i n:j];
                Data* mulresult = [nd mul:val];
                [row addObject:mulresult];
            }
            [newdata addObject:row];
        }
        return [[Matrix alloc] init:newdata];
    }
    return nil;
}

-(Data*) div:(Data*) another {
    if([another class] == [Number class]) {
        // Mul with number
        Number* nd = (Number*)another;
        NSMutableArray* newdata = [[NSMutableArray alloc] init];
        for(int i = 0;i< [self m];i++) {
            NSMutableArray* row = [[NSMutableArray alloc] init];
            for(int j = 0 ; j < [self n];j++) {
                Number* val = [self val:i n:j];
                Data* divresult = [val div:nd ];
                [row addObject:divresult];
            }
            [newdata addObject:row];
        }
        return [[Matrix alloc] init:newdata];
    } else {
        [Log error:@"Matrix can only be divided by number"];
        return nil;
    }
}

-(Number*) val:(NSInteger) i n:(NSInteger)j {
    NSMutableArray* row = (NSMutableArray*)[[self data] objectAtIndex:i];
    Data* item = [row objectAtIndex:j];
    assert([item class] == [Number class]);
    return (Number*)item;
}

-(void)setVal:(NSInteger)i n:(NSInteger)j val:(Number *)value {
    // Append Expressions
    while(i >= [[self data] count]) {
        NSMutableArray* newrow = [[NSMutableArray alloc] init];
        [[self data] addObject:newrow];
    }
    NSMutableArray* row = (NSMutableArray*)[[self data] objectAtIndex:i];
    while(j>= [row count]) {
        [row addObject:nil];
    }
    [row setObject:value atIndexedSubscript:j];
    if(i >= [self m])
        self->_m = i+1;
    if(j >= [self n])
        self->_n = j+1;
}

-(Matrix*) transpose {
    NSMutableArray* selfdata = [self data];
    NSMutableArray* newdata = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < [self n];i++) {
        NSMutableArray* row = [[NSMutableArray alloc] init];
        for(int j = 0 ; j < [self m]; j++) {
            [row addObject:[(NSMutableArray*)[selfdata objectAtIndex:j] objectAtIndex:i]];
        }
        [newdata addObject:row];
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
    NSMutableArray* data = [[NSMutableArray alloc] init];
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
            Data* pivotval = [[Integer ONE] div:[remain val:i n:i]];
            [pivot1 setVal:i n:i val:(Number*)pivotval];
            factor = (Matrix*)[pivot1 mul:factor];
            remain = (Matrix*)[pivot1 mul:remain];
            
            Matrix* reduce = [Matrix identity:size];
            
            for(NSInteger j = 0 ; j < size; j++) {
                if(j != i) {
                    Number* remval = [remain val:j n:i];
                    [reduce setVal:j n:i val: (Number*)[[Integer ZERO] sub:remval]];
                }
            }
            factor = (Matrix*)[reduce mul:factor];
            remain = (Matrix*)[reduce mul:remain];
        }
        return factor;
    }
    [Log error:@"Not a square matrix"];
    return nil;
}

-(Vector*) asVector {
    return nil;
}

@end
