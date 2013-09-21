//
//  Canvas2D.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewPort.h"


@interface Canvas2DView : UIView

@property(nonatomic,strong) ViewPort* viewPort;

-(IBAction) dragReceived:(id) gesture;
-(IBAction) tapReceived:(id) gesture;

-(ViewPort*) getViewPort;

@end
