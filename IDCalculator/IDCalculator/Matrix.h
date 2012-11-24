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
@property(nonatomic) NSInteger m;
@property(nonatomic) NSInteger n;
    
-(Matrix*) init:(NSArray*)d m:(NSInteger) nm n:(NSInteger)nn;
-(Matrix*) init:(ExpressionList*)data;

- (Matrix*) mul:(Matrix*)another;
- (Vector*) mulvector:(Vector*)v;
- (Number*) val:(NSInteger) i n:(NSInteger)j;
- (Number*) rank;
- (Number*) determinant;
- (Matrix*) submatrix:(NSRange) rowrange column:(NSRange) colrange;

-(SquareMatrix*) asSquare;
-(Vector*) asVector;
@end
