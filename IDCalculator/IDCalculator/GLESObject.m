//
//  GLESObject.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/27/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "GLESObject.h"

@implementation GLColor

static GLColor* RED;
static GLColor* BLUE;
static GLColor* GREEN;
static GLColor* WHITE;
static GLColor* BLACK;

+(void) initialize {
    RED = [GLColor construct:255 green:0 blue:0 alpha:255];
    GREEN = [GLColor construct:0 green:255 blue:0 alpha:255];
    BLUE = [GLColor construct:0 green:0 blue:255 alpha:255];
    WHITE = [GLColor construct:255 green:255 blue:255 alpha:255];
    BLACK = [GLColor construct:0 green:0 blue:0 alpha:0];
}

+(GLColor*) construct:(GLubyte)red green:(GLubyte)green blue:(GLubyte)blue alpha:(GLubyte)alpha {
    GLColor* color = [[GLColor alloc] init];
    color.red = red;
    color.green = green;
    color.blue = blue;
    color.alpha = alpha;
    return color;
}

+(GLColor*) RED {
    return RED;
}

+ (GLColor *)BLUE {
    return BLUE;
}

+(GLColor *)BLACK {
    return BLACK;
}
+(GLColor *)WHITE {
    return WHITE;
}

+(GLColor *)GREEN {
    return GREEN;
}

@end

@implementation GLPoint

+(GLPoint*) construct:(GLfloat)x y:(GLfloat) y z:(GLfloat)z color:(GLColor*) color {
    GLPoint* point = [[GLPoint alloc] init];
    point.x = x;
    point.y = y;
    point.z = z;
    point.color = color;
    return point;
}

@end

@implementation GLESObject {
    NSMutableArray* points;
    GLfloat* pointArray;
    GLubyte* colorArray;
}

-(GLESObject*) init {
    self = [super init];
    if(self) {
        self->points = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(void) add:(GLPoint*) point {
    [self->points addObject:point];
    [self freeArrays];
}

-(void) dealloc {
    [self freeArrays];
}

-(void) freeArrays {
    if(NULL!= pointArray)
        free(pointArray);
    if(NULL!= colorArray)
        free(colorArray);
}

-(void) render {
    glVertexPointer(3, GL_FLOAT, 0, [self pointArray]);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, [self colorArray]);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

-(GLfloat*) pointArray {
    if(pointArray != NULL)
        return pointArray;
    pointArray = malloc(sizeof(GLfloat)*[points count]*3);
    for(int i = 0 ; i < [points count] ; i++) {
        GLPoint* point = (GLPoint*)[points objectAtIndex:i];
        *(pointArray + i*3) = point.x;
        *(pointArray + i*3+1) = point.y;
        *(pointArray + i*3+2) = point.z;
    }
    return pointArray;
}

-(GLubyte*) colorArray {
    if(colorArray != NULL)
        return colorArray;
    colorArray = malloc(sizeof(GLubyte)*[points count]*4);
    for(int i = 0 ; i < [points count] ; i++) {
        GLPoint* point = (GLPoint*)[points objectAtIndex:i];
        *(colorArray + i*4) = point.color.red;
        *(colorArray + i*4+1) = point.color.green;
        *(colorArray + i*4+2) = point.color.blue;
        *(colorArray + i*4+3) = point.color.alpha;
    }
    return colorArray;
}


@end
