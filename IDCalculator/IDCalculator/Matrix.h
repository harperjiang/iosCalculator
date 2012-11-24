//
//  Matrix.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "Data.h"

@class Vector;

@interface Matrix : Data

@property(nonatomic,strong) NSArray* data;
@property(nonatomic) NSInteger m;
@property(nonatomic) NSInteger n;
    
-(Matrix*) init:(NSArray*)d m:(NSInteger) nm n:(NSInteger)nn;
-(Matrix*) init:(NSArray*)d;

- (Matrix*) mul:(Matrix*)another;
- (Vector*) mulvector:(Vector*)v;
- (Constant*) val:(NSInteger) i n:(NSInteger)j;
- (Constant*) rank;
- (Constant*) determinant;
- (Matrix*) submatrix:(NSRange) rowrange column:(NSRange) colrange;

@end
