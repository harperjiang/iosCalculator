//
//  PadHelpViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/20/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "PadHelpViewController.h"

@interface PadHelpViewController ()

@end

@implementation PadHelpViewController

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
	// Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://www.clarkson.edu"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
