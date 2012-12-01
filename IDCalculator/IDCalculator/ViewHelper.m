//
//  ViewHelper.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/28/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+(void) consoleWillLoad:(UIView*) view {
    
}

+(void) consoleWillAppear:(UITextView*) console {
    // Load setting and set font
    NSNumber* fontsize = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"console_textsize"];
    
    NSInteger val = 14;
    if(nil != fontsize)
        val = [fontsize integerValue];
    
    [console setFont:[UIFont systemFontOfSize:val]];
    
}


@end
