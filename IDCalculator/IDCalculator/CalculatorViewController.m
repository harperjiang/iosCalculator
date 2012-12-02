//
//  CalculusViewController.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "CalculatorViewController.h"
#import "FunctionParser.h"


@implementation CalculatorViewController {
    NSMutableString* buffer;
}

-(NSMutableString*) buffer {
    return buffer;
}

-(id)init {
    self = [super init];
    if(self) {
        buffer = [[NSMutableString alloc] initWithCapacity:100];
    }
    return self;
}

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

-(void) appendText:(NSString*) text {
    if([self textView]) {
        NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
        [stringBuffer appendString:[[self textView] text]];
        [stringBuffer appendString:text];
        [[self textView] setText:stringBuffer];
    }
    // Buffer
    [buffer appendString:text];
}

-(void) output: (NSString*) text {
    NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
    [stringBuffer appendString:[[self textView] text]];
    [stringBuffer appendFormat:@"%@\n",text];
    [[self textView] setText:stringBuffer];
}

-(IBAction) equalButtonClicked:(id)sender {
    // Do calculation
    NSString* output = [[Calculator instance] calculate : buffer];
    [self output:output];
    // Clear
    [buffer setString:@""];
}

-(IBAction) backspaceButtonClicked:(id)sender {
    if( [[[self textView] text] length] ==0)
        return;
    NSMutableString* stringBuffer = [[NSMutableString alloc] initWithCapacity:20];
    [stringBuffer appendString:[[self textView] text]];
    [stringBuffer deleteCharactersInRange:NSMakeRange([stringBuffer length]-1, 1)];
    [[self textView] setText:stringBuffer];
    // Buffer
    [buffer deleteCharactersInRange:NSMakeRange([buffer length] -1, 1)];
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

- (IBAction) textButtonClicked:(id) sender {
    UIButton* button = (UIButton*) sender;
    [self appendText:[[button titleLabel] text]];
}

@end
