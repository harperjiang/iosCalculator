//
//  DummyViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/26/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
	// Load the page
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://www.google.com"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
