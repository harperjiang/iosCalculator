//
//  ViewControllerHelper.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/16/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Canvas2DView.h"

@interface ViewControllerHelper : NSObject

+(Canvas2DView*) getCanvasView:(UIWindow*) window;

@end
