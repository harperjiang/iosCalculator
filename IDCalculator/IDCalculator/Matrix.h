//
//  Matrix.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Number.h"
#import "ExpressionList.h"
#import "Data.h"

@class Vector;
@class SquareMatrix;

@interface Matrix : Data

@property(nonatomic,strong) ExpressionList* data;
@property(nonatomic,readonly) NSInteger m;
@property(nonatomic,readonly) NSInteger n;

+(Matrix*) identity:(NSInteger) num;

-(Matrix*) init:(NSArray*)d m:(NSInteger) nm n:(NSInteger)nn;
-(Matrix*) init:(ExpressionList*)data;

- (Number*) val:(NSInteger) i n:(NSInteger)j;
- (void) setVal:(NSInteger) i n:(NSInteger)j val:(Number*)value;

- (NSInteger) rank;
- (Number*) determinant;

- (Matrix*) transpose;

- (Matrix*) submatrix:(NSRange) rowrange column:(NSRange) colrange;

- (Matrix*) inverse;


-(Vector*) asVector;
@end
