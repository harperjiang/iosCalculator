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

-(IBAction) backspaceButtonClicked:(id)sender {
    if( [[[self textView] text] length] ==0)
        return;
    NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
    [stringBuffer appendString:[[self textView] text]];
    [stringBuffer deleteCharactersInRange:NSMakeRange([stringBuffer length]-1, 1)];
    [[self textView] setText:stringBuffer];
}

-(IBAction) equalButtonClicked:(id)sender {
    
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

- (IBAction) numberButtonClicked:(id) sender {
    UIButton* button = (UIButton*) sender;
    [self appendText:[[button titleLabel] text]];
}

- (IBAction) oprButtonClicked:(id) sender {
    UIButton* button = (UIButton*) sender;
    [self appendText:[[button titleLabel] text]];
}

-(IBAction) powerButtonClicked:(id) sender {
    [self appendText:@"^"];
}

-(IBAction) integrateButtonClicked:(id) sender {
    [self appendText:@"∫"];
}

-(IBAction) differentiateButtonClicked:(id) sender {
    [self appendText:@"d"];
}

-(IBAction) lpButtonClicked:(id) sender {
    [self appendText:@"("];
}

-(IBAction) rpButtonClicked:(id) sender {
    [self appendText:@")"];
}

-(IBAction) dxButtonClicked:(id) sender {
    [self appendText:@"dx"];
}

-(IBAction) xButtonClicked:(id) sender {
    [self appendText:@"x"];
}

-(IBAction) eButtonClicked:(id) sender {
    [self appendText:@"e"];
}

-(IBAction) piButtonClicked:(id) sender {
    [self appendText:@"π"];
}

@end
