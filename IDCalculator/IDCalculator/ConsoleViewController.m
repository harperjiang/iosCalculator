//
//  ConsoleViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ConsoleViewController.h"
#import <UIKit/UIDevice.h>

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

@interface ConsoleViewController ()

@end

@implementation ConsoleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) editingDone: (id) sender {
    // Hide keyboard
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Add listener to text box
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWillChange:(NSNotification *)notification {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        
        CGRect viewBounds = self.view.frame;
        CGRect textFieldBounds = self.inputField.frame;
        CGRect displayBounds = self.display.frame;
                
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        
        if(keyboardBounds.origin.y >= viewBounds.size.height) {
            // keyboard is hidden
            NSInteger offset = viewBounds.size.height - textFieldBounds.origin.y - textFieldBounds.size.height;
            displayBounds.size.height += offset;
            textFieldBounds.origin.y += offset;
            [[self display] setFrame:displayBounds];
            [[self inputField] setFrame:textFieldBounds];
        } else {
            NSInteger offset = viewBounds.size.height - keyboardBounds.origin.y+20;
            displayBounds.size.height -= offset;
            textFieldBounds.origin.y -= offset;
            [[self display] setFrame:displayBounds];
            [[self inputField] setFrame:textFieldBounds];
        }
        
        [UIView commitAnimations];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    }
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self inputField] resignFirstResponder];
}

@end
