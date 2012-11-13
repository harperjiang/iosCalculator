//
//  SquareMatrix.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Matrix.h"

@interface Eigenvalue : NSObject

@property(nonatomic,readonly,strong) Constant* value;
@property(nonatomic,readonly,strong) NSArray* eigenvectors;

@end

@interface SquareMatrix : Matrix

@property(nonatomic) NSInteger size;

-(Matrix*) inverse;
-(NSArray*) eigenvalues;

@end
