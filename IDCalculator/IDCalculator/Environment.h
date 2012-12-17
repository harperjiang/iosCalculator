//
//  Environment.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "DrawContainer.h"
#import "Coordinate.h"

@interface Environment : NSObject <Drawable>

@property(nonatomic,strong) Coordinate* coordinate;
@property(nonatomic,strong) DrawContainer* content;

@end
