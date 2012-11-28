//
//  SquareMatrix.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Matrix.h"

@interface Eigenvalue : NSObject

@property(nonatomic,readonly,strong) Number* value;
@property(nonatomic,readonly,strong) NSArray* eigenvectors;

@end

@interface SquareMatrix : Matrix

-(SquareMatrix*) inverse;
-(NSArray*) eigenvalues;

@end
