//
//  DrawObject.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/16/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Drawable.h"

@interface DrawObject : NSObject <Drawable>

@property(nonatomic) CGColorRef fillColor;
@property(nonatomic) CGColorRef lineColor;
@property(nonatomic) CGFloat lineWidth;


-(void) paint:(CGContextRef) context;

@end
