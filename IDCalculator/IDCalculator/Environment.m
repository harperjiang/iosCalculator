//
//  Environment.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Environment.h"
#import "PartialDrawable.h"
#import "Coordinate.h"
#import "Element.h"
#import "ViewPort.h"

@implementation Environment

-(Environment*)init {
    self = [super init];
    if(self) {
        // FIXME For test only, add test item to environment
        [self addElement:[[Coordinate alloc] init]];
    }
    return self;
}

@end
