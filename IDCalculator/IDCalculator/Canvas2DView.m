//
//  Canvas2D.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Canvas2DView.h"

@implementation Canvas2DView {
    CGPoint lastPoint;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(ViewPort*) getViewPort {
    if(self.viewPort == nil) {
        self.viewPort = [[ViewPort alloc] init];
    }
    return self.viewPort;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [[self getViewPort] draw:ref];
}

-(IBAction) dragReceived:(UIPanGestureRecognizer*)gesture {
    UIGestureRecognizerState state = [gesture state];
    CGPoint point = [gesture locationInView:self];
    if(state == UIGestureRecognizerStateBegan) {
        lastPoint.x = point.x;
        lastPoint.y = point.y;
    }
    if(state == UIGestureRecognizerStateChanged) {
        CGPoint vector = CGPointMake(point.x - lastPoint.x,point.y - lastPoint.y);
        // Doing transformation
        [[self viewPort] transform: &vector];
        CGPoint currentCenter = [[self viewPort] center];
        [[self viewPort] setCenter:CGPointMake(currentCenter.x-vector.x, currentCenter.y-vector.y)];
        [self setNeedsDisplay];
        lastPoint.x = point.x;
        lastPoint.y = point.y;
    }
    if(state == UIGestureRecognizerStateEnded) {
        
    }
}

@end
