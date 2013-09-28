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

+(UIView*) lookupView: (UIView*) current class:(id) clazz {
    if([current isKindOfClass:clazz])
        return current;
    for (NSInteger i = 0; i < current.subviews.count; i++) {
        UIView* sub = [ViewUtils lookupView:(UIView*)[current.subviews objectAtIndex:i] class:clazz];
        if(sub!= nil)
            return sub;
    }
    return nil;
}

+(UIView*) getViewByClass: (id) clazz {
    IDCAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    UITabBarController* tab = (UITabBarController*)delegate.window.rootViewController;
    for(int i = 0 ; i < [tab viewControllers].count; i++) {
        UIViewController* viewController = (UIViewController*)[[tab viewControllers] objectAtIndex:i];
        UIView* result = [self lookupView:[viewController view] class: clazz];
        if(result != nil) {
            return result;
        }
    }
    return nil;
}


@end
