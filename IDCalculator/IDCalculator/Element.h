//
//  Element.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractDrawObject.h"
#import "PartialDrawable.h"

@class Environment;

@interface Element : AbstractDrawObject<PartialDrawable>

@property(nonatomic) CGRect range;
@property(nonatomic,strong) Element* parent;

-(Environment*) environment;
-(CGFloat) translate:(CGFloat) input;

@end
