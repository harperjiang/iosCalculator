//
//  PartialDrawable.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Drawable.h"

@protocol PartialDrawable <Drawable>

-(void) setRange:(CGRect) range;

@end
