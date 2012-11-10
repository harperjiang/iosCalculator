//
//  Matrix.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector.h"
#import "Constant.h"


@interface Matrix : NSObject

@property(nonatomic) NSArray* data;
@property(nonatomic) NSInteger m;
@property(nonatomic) NSInteger n;
    

- (Matrix*) mul:(Matrix*)another;
- (Vector*) mulvector:(Vector*)v;
- (Constant*) val:(NSInteger) i n:(NSInteger)j;

@end
