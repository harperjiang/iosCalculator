//
//  CalculusViewController.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CalculatorViewController.h"


@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) appendText:(NSString*) text {
    if([self textView]) {
        NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
        [stringBuffer appendString:[[self textView] text]];
        [stringBuffer appendString:text];
        [[self textView] setText:stringBuffer];
    }
}

- (IBAction) sinButtonClicked:(id) sender {
    [self appendText:@"sin("];
}

- (IBAction) cosButtonClicked:(id) sender {
    [self appendText:@"cos("];
}

- (IBAction) lnButtonClicked:(id) sender {
    [self appendText:@"ln("];

}

@end
