//
//  OpenGLHelper.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OpenGLContext : NSObject

- (OpenGLContext*) init:(CAEAGLLayer*) layer;

- (void) createContext;

-(void) beginDraw;
-(void) finishDraw;

-(void) setupView;

@end
