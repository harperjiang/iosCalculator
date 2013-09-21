//
//  FunctionGraph.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/17/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "FunctionGraph.h"
#import "Environment.h"
#import "Decimal.h"


@implementation FunctionGraph

-(FunctionGraph*) init:(Function*) func {
    self = [super init];
    if(self) {
        self.function = func;
    }
    return self;
}

-(void) paint:(CGContextRef)context {
    CGFloat unit = [self translate:1];
    CGRect range = [[self environment] range];
    CGFloat x = range.origin.x;
    CGFloat stop = range.origin.x + range.size.width;
    CGFloat ymin = range.origin.y;
    CGFloat ymax = range.origin.y + range.size.height;
    
    NSMutableDictionary* vars = [[NSMutableDictionary alloc] init];
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:(int)ceil(range.size.height/unit)];
    
    while(x <= stop) {
        
        [vars setObject:[Decimal constructDouble:(double)x] forKey:@"x"];
        Decimal* result = [[self function] calculate:vars];
        if(result == [Decimal nan]) {
            // Ignore
        } else {
            CGFloat y = (CGFloat)[[result value] doubleValue];
            if(y <= ymax && y >= ymin) {
                [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        }
        x += 5*unit;
    }
    if([array count] == 0)
        return;
       
    CGContextBeginPath(context);

    CGPoint first = [(NSValue*) [array objectAtIndex: 0] CGPointValue];
    CGContextMoveToPoint(context, first.x, first.y);
    for(NSInteger i = 1 ; i < [array count]; i++) {
        CGPoint next = [(NSValue*) [array objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, next.x, next.y);
    }
    
    CGContextStrokePath(context);
}

@end
