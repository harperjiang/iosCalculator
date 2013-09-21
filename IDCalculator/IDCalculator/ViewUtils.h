//
//  ViewUtils.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/20/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewUtils : NSObject

+(UIView*) currentView;
+(UIView*) getViewByClass: (id) clazz;

@end
