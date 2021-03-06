//
//  Environment.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ElementContainer.h"

@class ViewPort;

@interface Environment : ElementContainer

@property(nonatomic,strong) ViewPort* viewPort;

@end
