//
//  Vector.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Vector.h"

@implementation Vector

-(Constant*) val:(NSInteger)i {
    return [[self data] objectAtIndex:i];
}

@end
