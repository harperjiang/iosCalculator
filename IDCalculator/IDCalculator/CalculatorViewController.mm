//
//  CalculusViewController.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CalculatorViewController.h"
#import "FunctionParser.h"
#import "ViewHelper.h"


@implementation CalculatorViewController {
    NSMutableString* buffer;
}

-(NSMutableString*) buffer {
    if(nil == buffer)
        buffer = [[NSMutableString alloc] initWithCapacity:100];
    return buffer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewHelper calculatorWillAppear:self.textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) appendText:(NSString*) text {
    if([self textView]) {
        NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
        [stringBuffer appendString:[[self textView] text]];
        [stringBuffer appendString:text];
        [[self textView] setText:stringBuffer];
    }
    // Buffer
    [[self buffer] appendString:text];
}

-(void) output: (NSString*) text {
    NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
    [stringBuffer appendString:[[self textView] text]];
    [stringBuffer appendFormat:@"%@\n",text];
    [[self textView] setText:stringBuffer];
}

-(IBAction) equalButtonClicked:(id)sender {
    if([[self buffer] length] != 0) {
    // Do calculation
        NSString* output = [[Calculator instance] calculate : buffer];
        [self output: [NSString stringWithFormat:@"=%@",output]];
    }
    // Clear
    [[self buffer] setString:@""];
}

-(IBAction) backspaceButtonClicked:(id)sender {
    if( [[[self textView] text] length] ==0)
        return;
    NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
    [stringBuffer appendString:[[self textView] text]];
    [stringBuffer deleteCharactersInRange:NSMakeRange([stringBuffer length]-1, 1)];
    [[self textView] setText:stringBuffer];
    // Buffer
    if([[self buffer] length] > 0)
        [[self buffer] deleteCharactersInRange:NSMakeRange([buffer length] -1, 1)];
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

-(void)powerButtonClicked:(id)sender {
    [self appendText:@"^"];
}

- (IBAction) textButtonClicked:(id) sender {
    UIButton* button = (UIButton*) sender;
    [self appendText:[[button titleLabel] text]];
}

-(void)horizontalSwipeReceived:(id)gesture {
//    UISwipeGestureRecognizer* swipe = (UISwipeGestureRecognizer*)gesture;
    [self cleanDisplay];
}

-(void) backspaceButtonRepeated:(id) sender {
    [self cleanDisplay];
}

-(void) cleanDisplay {
    [[self buffer] setString:@""];
    [self.textView setText:@""];
}

@end
