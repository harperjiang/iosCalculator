//
//  ContextManager.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ContextManager.h"

@implementation ContextManager

static EAGLSharegroup* sharegroup;

+(EAGLContext*) createContext {
    EAGLContext* context = [EAGLContext currentContext];
    if(context == nil) {
        if(sharegroup == nil) {
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
            if(nil == context)
                context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
            sharegroup = [context sharegroup];
        } else {
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:sharegroup];
            if(nil == context)
                context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1 sharegroup:sharegroup];
        }
        [EAGLContext setCurrentContext:context];
    }
    return context;
}

@end
