//
//  Environment.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Environment.h"

@implementation Environment

-(id)init {
    self = [super init];
    if(self) {
        self.content = [[DrawContainer alloc] init];
        self.coordinate = [[Coordinate alloc] init];
    }
    return self;
}

-(void)draw:(CGContextRef)context {
    [self.coordinate draw:context];
    [self.content draw:context];
}

@end
