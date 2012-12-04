//
//  ViewHelper.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/28/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewHelper : NSObject

+(void) consoleWillLoad:(UIView*) view;
+(void) consoleWillAppear:(UITextView*) view;

+(void) calculatorWillAppear:(UITextView*) view;
@end
