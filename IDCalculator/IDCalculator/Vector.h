//
//  Vector.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "Matrix.h"

@interface Vector : Matrix

@property(nonatomic,strong) NSArray* data;
@property(nonatomic) NSInteger size;

-(Constant*) val:(NSInteger) i;
-(Vector*) init:(NSMutableArray*) data;

@end
