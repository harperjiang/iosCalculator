//
//  Canvas2D.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Canvas2DView.h"

@implementation Canvas2DView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(Environment*) getEnvironment {
    if(self.environment == nil) {
        self.environment = [[Environment alloc] init];
    }
    return self.environment;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [[self getEnvironment] draw:ref];
}


@end
