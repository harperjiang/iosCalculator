//
//  GLESContainer.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/27/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "GLESObject.h"

@interface GLESContainer : GLESObject

-(void) add:(GLESObject*) child;
-(void) remove:(GLESObject*) child;

@end
