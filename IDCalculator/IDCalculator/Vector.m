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
    return [super val:0 n:i];
}

-(Vector*) init:(NSMutableArray *)data {
    self = [super init];
    if(self) {
        [self setData:data];
        [self setSize:[data count]];
    }
    return self;
}

@end
