//
//  Environment.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/15/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"

@interface DrawContainer : NSObject <Drawable>

-(void) addObject:(id<Drawable>) object;
-(void) removeObject:(id<Drawable>) object;

@end
