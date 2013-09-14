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
    // FIXME For test only, add test item to environment
    
    
    
    return self;
}

-(void)draw:(CGContextRef)context {
    [self.coordinate draw:context];
    // Make a transform to origin point
    CGRect rect = CGContextGetClipBoundingBox(context);
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    CGContextScaleCTM(context, 1, -1);
    [self.content draw:context];
}

@end
