//
//  GLESObject.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/27/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

@interface GLColor : NSObject
@property GLubyte red;
@property GLubyte green;
@property GLubyte blue;
@property GLubyte alpha;

+(GLColor*) construct:(GLubyte) red green:(GLubyte) green blue:(GLubyte) blue alpha:(GLubyte) alpha;

+(GLColor*) RED;
+(GLColor*) GREEN;
+(GLColor*) BLUE;
+(GLColor*) WHITE;
+(GLColor*) BLACK;

@end

@interface GLPoint : NSObject

@property GLfloat x;
@property GLfloat y;
@property GLfloat z;
@property GLColor* color;

+(GLPoint*) construct:(GLfloat)x y:(GLfloat) y z:(GLfloat)z color:(GLColor*) color;

@end

@interface GLESObject : NSObject

-(void) add:(GLPoint*) point;
-(void) render;

-(GLfloat*) pointArray;
-(GLubyte*) colorArray;

@end
