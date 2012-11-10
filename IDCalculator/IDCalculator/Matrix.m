//
//  Matrix.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Matrix.h"
#import "IntegerConstant.h"
#import "Constant.h"

@implementation Matrix

-(Matrix*) init:(NSArray*)d m:(NSInteger) nm n:(NSInteger)nn {
    self = [super init];
    if(self) {
        [self setData:d];
        [self setM:nm];
        [self setN:nn];
    }
    return self;
}


-(Matrix*) mul:(Matrix *)another {
    if([another m] == [self n]) {
        // n square speed
        NSMutableArray* newData = [[NSMutableArray alloc] initWithCapacity:[self m]*[another n]];
        for (int i = 0 ; i < [self m]; i++) {
            for(int j = 0 ; j < [another n]; j++) {
                Constant* sum = [IntegerConstant ZERO];
                for(int k = 0 ; k < [self n] ; k++) {
                    sum = [sum add: [[self val:i n:k] mul:[another val:k n:j]]];
                }
                [newData insertObject:sum atIndex:i*[another n]+j];
            }
        }
        return [[Matrix alloc] init:newData m:[self m] n:[another n]];
    }
    return nil;
}

-(Vector*) mulvector:(Vector *)v {
    NSMutableArray* newData = [[NSMutableArray alloc] initWithCapacity:[self m]];
    if([self n] == [v size]) {
        for(int i = 0 ; i < [self m]; i++) {
            Constant* sum = [IntegerConstant ZERO];
            for(int j = 0 ; j < [self n]; j++) {
                sum = [sum add: [[self val:i n:j] mul:[v val:j]]];
            }
            [newData insertObject:sum atIndex:i];
        }
    }
    return nil;
}

-(Constant*) val:(NSInteger) i n:(NSInteger)j {
    return [[self data] objectAtIndex:i*self.n + j];
}

@end
