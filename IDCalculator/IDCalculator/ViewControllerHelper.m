//
//  ViewControllerHelper.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/16/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ViewControllerHelper.h"
#import "Canvas2DView.h"

@implementation ViewControllerHelper

+(Canvas2DView *)getCanvasView:(UIWindow *)window {
    UITabBarController* tab = (UITabBarController*)window.rootViewController;
    for(int i = 0 ; i < [tab.childViewControllers count] ; i++ ) {
        UIViewController* vc = (UIViewController*) [tab.childViewControllers objectAtIndex:i];
        if([[vc view] isKindOfClass:[Canvas2DView class]])
            return (Canvas2DView*)[vc view];
    }
    return nil;
}

@end
