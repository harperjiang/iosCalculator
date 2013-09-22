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

static int STATE_NAN = 0;
static int STATE_NOT_IN_RANGE = 1;
static int STATE_IN_RANGE = 2;

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
    
    NSInteger maxmove = (NSInteger)ceil(range.size.height/unit);
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:maxmove];
    NSMutableArray* currentline = [[NSMutableArray alloc] initWithCapacity:maxmove];
    
    int from = STATE_NOT_IN_RANGE;
    int to = STATE_NOT_IN_RANGE;
    
    while(x <= stop) {
        from = to;
        [vars setObject:[Decimal constructDouble:(double)x] forKey:@"x"];
        Decimal* result = [[self function] calculate:vars];
        CGFloat y;
        if(result == [Decimal nan] || result == nil) {
            // Ignore
            to = STATE_NAN;
        } else {
            y = (CGFloat)[[result value] doubleValue];
            if(y <= ymax && y >= ymin) {
                to = STATE_IN_RANGE;
            } else {
                to = STATE_NOT_IN_RANGE;
            }
        }
        // If nan, break the line and restart one
        if(to == STATE_NAN) {
            if(currentline.count > 0) {
                [array addObject:currentline];
                currentline = [[NSMutableArray alloc] initWithCapacity:maxmove];
            }
        }
        if(to == STATE_IN_RANGE) {
                [currentline addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        }
        if(to == STATE_NOT_IN_RANGE) {
            if(from == STATE_IN_RANGE) {
                [currentline addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
            if(from == STATE_NOT_IN_RANGE) {
                if(currentline.count > 1) {
                    [array addObject:currentline];
                    currentline = [[NSMutableArray alloc] initWithCapacity:maxmove];
                }
                [currentline removeAllObjects];
                [currentline addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        }
        
        x += 3*unit;
    }
    // Add the last line
    if(currentline.count >0)
       [array addObject:currentline];
    
    // No lines?
    if([array count] == 0)
        return;
    
    // Draw the lines
    for(NSInteger i = 0; i < array.count ; i++) {
        NSArray* currentArray = [array objectAtIndex:i];
        CGContextBeginPath(context);
        CGPoint first = [(NSValue*) [currentArray objectAtIndex: 0] CGPointValue];
        CGContextMoveToPoint(context, first.x, first.y);
        for(NSInteger j = 1 ; j < [currentArray count]; j++) {
            CGPoint next = [(NSValue*) [currentArray objectAtIndex:j] CGPointValue];
            CGContextAddLineToPoint(context, next.x, next.y);
        }
        
        CGContextStrokePath(context);
    }
}

@end
