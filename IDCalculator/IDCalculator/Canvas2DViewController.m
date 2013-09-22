//
//  Canvas2DViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/20/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Canvas2DViewController.h"

@interface Canvas2DViewController ()

@end

@implementation Canvas2DViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[self canvas] getViewPort];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
