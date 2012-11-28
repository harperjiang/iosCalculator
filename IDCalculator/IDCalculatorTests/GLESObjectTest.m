//
//  GLESObjectTest.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/27/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "GLESObjectTest.h"
#import "GLESObject.h"

@implementation GLESObjectTest

-(void) testPointArray {
    GLESObject* obj = [[GLESObject alloc] init];
    [obj add:[GLPoint construct:1.0f y:1.0f z:1.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:1.0f y:0.0f z:1.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:1.0f z:1.0f color:[GLColor RED]]];
    
    GLfloat* pointArray = [obj pointArray];
    
    STAssertEquals(pointArray[0], 1.0f, @"");
    STAssertEquals(pointArray[1], 1.0f, @"");
    STAssertEquals(pointArray[2], 1.0f, @"");
    STAssertEquals(pointArray[3], 1.0f, @"");
    STAssertEquals(pointArray[4], 0.0f, @"");
    STAssertEquals(pointArray[5], 1.0f, @"");
}

-(void) testColorArray {
    GLESObject* obj = [[GLESObject alloc] init];
    [obj add:[GLPoint construct:1.0f y:1.0f z:1.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:1.0f y:0.0f z:1.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:1.0f z:1.0f color:[GLColor RED]]];

    GLubyte* colorArray = [obj colorArray];
    
    STAssertEquals(colorArray[0], (GLubyte)255, @"");
    STAssertEquals(colorArray[1], (GLubyte)0, @"");
    STAssertEquals(colorArray[2], (GLubyte)0, @"");
    STAssertEquals(colorArray[3], (GLubyte)255, @"");
    STAssertEquals(colorArray[4], (GLubyte)255, @"");
    STAssertEquals(colorArray[5], (GLubyte)0, @"");
}

@end
