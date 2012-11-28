//
//  GraphViewController.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface GraphViewController : GLKViewController

@property(nonatomic,strong) IBOutlet GLKView* graphView;

-(IBAction) rotationReceived:(id)gesture;
-(IBAction) pinchReceived:(id) gesture;
-(IBAction) swipeReceived:(id) gesture;
@end
