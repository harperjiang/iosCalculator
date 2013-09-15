//
//  ViewPort.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AbstractDrawObject.h"
#import "Environment.h"


@interface ViewPort : AbstractDrawObject

@property(nonatomic,strong) Environment* environment;
@property(nonatomic,readwrite) CGPoint center;
@property(nonatomic,readwrite) CGFloat proportion;

-(void) transform:(CGPoint*) input;

@end
