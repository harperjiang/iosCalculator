//
//  OpenGLHelper.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "OpenGLContext.h"

@implementation OpenGLContext {
    
    GLuint framebuffer;
    GLuint renderbuffer;
    GLuint depthbuffer;
    GLint width;
    GLint height;
    
    CAEAGLLayer* layer;
    
    EAGLContext* context;
}

-(OpenGLContext*) init:(CAEAGLLayer *)l {
    self = [super init];
    if(self) {
        self->layer = l;
        [self createContext];
        [self createFramebuffer];
        [self setupView];
    }
    return self;
}

- (void) createContext {
    context = [EAGLContext currentContext];
    if(context == nil) {
        context = nil;//[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        if(nil == context)
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        [EAGLContext setCurrentContext:context];
    }
}

-(void) createFramebuffer {  
    [EAGLContext setCurrentContext:context];
    
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    
    glGenRenderbuffers(1, &renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, renderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self->layer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderbuffer);
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &height);
    
    glGenRenderbuffers(1, &depthbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthbuffer);
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER) ;
    if(status != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"failed to make complete framebuffer object %x", status);
    }
}

-(void) destroyFramebuffer {
    glDeleteBuffers(1,&framebuffer);
    framebuffer = 0;
    glDeleteRenderbuffers(1, &renderbuffer);
    renderbuffer = 0;
    glDeleteRenderbuffers(1, &depthbuffer);
    depthbuffer = 0;
}

- (void) setupView {
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(-5.0f, 5.0f, -5.0f, 5.0f, -10.0f, 10.0f);
    glMatrixMode(GL_MODELVIEW);
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_VERTEX_ARRAY);
}

- (void) beginDraw {
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glMatrixMode(GL_MODELVIEW);
    glClear(GL_COLOR_BUFFER_BIT);
    glLoadIdentity();
}

- (void) finishDraw {
    glBindRenderbuffer(GL_RENDERBUFFER, renderbuffer);
    [context presentRenderbuffer:renderbuffer];
}

@end
