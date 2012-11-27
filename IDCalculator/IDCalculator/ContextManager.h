//
//  ContextManager.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface ContextManager : NSObject

+(EAGLContext*) createContext;

@end
