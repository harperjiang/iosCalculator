//
//  ViewUtils.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/20/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ViewUtils.h"
#import "IDCAppDelegate.h"

@implementation ViewUtils

+(UIView*) currentView {
    IDCAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    UITabBarController* tab = (UITabBarController*)delegate.window.rootViewController;
    return [[tab selectedViewController] view];
}

+(UIView*) getViewByClass: (id) clazz {
    IDCAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    UITabBarController* tab = (UITabBarController*)delegate.window.rootViewController;
    for(int i = 0 ; i < [tab viewControllers].count; i++) {
        if([[(UIViewController*)[[tab viewControllers] objectAtIndex:i] view] isKindOfClass:clazz]) {
            return [[[tab viewControllers] objectAtIndex:i] view];
        }
    }
    return nil;
}


@end
