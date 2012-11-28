//
//  GraphViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "GraphViewController.h"
#import "OpenGLContext.h"
#import "GLESObject.h"
#import "GLESContainer.h"

@interface GraphViewController ()

@end

@implementation GraphViewController {
    OpenGLContext* context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    context = [[OpenGLContext alloc] init:(CAEAGLLayer*)[[self view] layer]];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self drawView];
}

- (void)drawView {
    [context beginDraw];
    // Replace the implementation of this method to do your own custom drawing
    
    GLESContainer* container = [[GLESContainer alloc] init];
    
    GLESObject* obj = [[GLESObject alloc] init];
    
    [obj add:[GLPoint construct:1.0f y:0.0f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.707f y:0.707f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:0.0f z:0.0f color:[GLColor GREEN]]];
    [obj add:[GLPoint construct:0.0f y:1.0f z:0.0f color:[GLColor RED]]];
    
    [container add:obj];
    
    obj = [[GLESObject alloc] init];
    
    [obj add:[GLPoint construct:0.0f y:1.0f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:-0.707f y:0.707f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:0.0f z:0.0f color:[GLColor GREEN]]];
    [obj add:[GLPoint construct:-1.0f y:0.0f z:0.0f color:[GLColor RED]]];
    
    [container add:obj];
    
    obj = [[GLESObject alloc] init];
    
    [obj add:[GLPoint construct:-1.0f y:0.0f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:-0.707f y:-0.707f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:0.0f z:0.0f color:[GLColor GREEN]]];
    [obj add:[GLPoint construct:0.0f y:-1.0f z:0.0f color:[GLColor RED]]];
    
    [container add:obj];
    
    obj = [[GLESObject alloc] init];
    
    [obj add:[GLPoint construct:0.0f y:-1.0f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.707f y:-0.707f z:0.0f color:[GLColor RED]]];
    [obj add:[GLPoint construct:0.0f y:0.0f z:0.0f color:[GLColor GREEN]]];
    [obj add:[GLPoint construct:1.0f y:0.0f z:0.0f color:[GLColor RED]]];
    
    [container add:obj];
    

    [container render];
    
    // Assuming you allocated a color renderbuffer to point at a Core Animation layer, you present its contents by making it the current renderbuffer
    // and calling the presentRenderbuffer: method on your rendering context.
    [context finishDraw];
}

-(IBAction)rotationReceived:(id)gesture {
    UIRotationGestureRecognizer* rotation = (UIRotationGestureRecognizer*)gesture;
    
}

-(IBAction)pinchReceived:(id)gesture {
    UIPinchGestureRecognizer* pinch = (UIPinchGestureRecognizer*)gesture;
}

-(IBAction)swipeReceived:(id)gesture {
    UISwipeGestureRecognizer* swipe = (UISwipeGestureRecognizer*)gesture;
}

@end
