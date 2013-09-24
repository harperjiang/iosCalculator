//
//  PadConsoleViewController.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/28/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "PadConsoleViewController.h"
#import "IDCConsole.h"
#import "ViewHelper.h"

@interface PadConsoleViewController ()

@end

@implementation PadConsoleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) editingDone: (id) sender {
    // Send Command to model
    [[IDCConsole instance] operate:[[self inputField] text]];
    // Clear the input
    [[self inputField] setText:nil];
    // Update Display
    [[self display] setText:[[IDCConsole instance] buffer]];
    // Scroll to the end
    [[self display] scrollRangeToVisible:NSMakeRange([[[self display] text] length], 0)];
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


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewHelper consoleWillAppear:[self display]];
}

- (void) keyboardWillChange:(NSNotification *)notification {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect oldKeyboardBounds;
        [keyboardBoundsValue getValue:&oldKeyboardBounds];
        CGRect windowBounds = self.view.window.frame;
        // Keyboard Bounds will not change when rotate changes, manually change
        
        CGRect viewBounds = self.view.frame;
        CGRect subviewBounds = self.keyboardView.frame;
        CGRect displayBounds = self.display.frame;
        
        CGRect keyboardBounds;
        
        UIInterfaceOrientation orientation = [self interfaceOrientation];
        NSInteger temp;
        switch(orientation) {
            case UIInterfaceOrientationPortrait:
                keyboardBounds.origin.x = oldKeyboardBounds.origin.x;
                keyboardBounds.origin.y = oldKeyboardBounds.origin.y;
                keyboardBounds.size.height = oldKeyboardBounds.size.height;
                keyboardBounds.size.width = oldKeyboardBounds.size.width;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                keyboardBounds.origin.x = 0 - windowBounds.size.width + oldKeyboardBounds.size.width;
                keyboardBounds.origin.y = windowBounds.size.height - oldKeyboardBounds.size.height - oldKeyboardBounds.origin.y;
                keyboardBounds.size.height = oldKeyboardBounds.size.height;
                keyboardBounds.size.width = oldKeyboardBounds.size.width;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                keyboardBounds.origin.x = 0;
                keyboardBounds.origin.y = oldKeyboardBounds.origin.x;
                keyboardBounds.size.height = oldKeyboardBounds.size.width;
                keyboardBounds.size.width = oldKeyboardBounds.size.height;
                
                temp = windowBounds.size.width;
                windowBounds.size.width = windowBounds.size.height;
                windowBounds.size.height = temp;
                break;
            case UIInterfaceOrientationLandscapeRight:
                keyboardBounds.origin.x = 0;
                keyboardBounds.origin.y = oldKeyboardBounds.origin.x + oldKeyboardBounds.size.width;
                keyboardBounds.size.height = oldKeyboardBounds.size.width;
                keyboardBounds.size.width = oldKeyboardBounds.size.height;
                
                temp = windowBounds.size.width;
                windowBounds.size.width = windowBounds.size.height;
                windowBounds.size.height = temp;
                break;
            default:
                break;
        }
        
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        
        NSInteger IOS7_OFFSET = 56;
        if(keyboardBounds.origin.y >= windowBounds.size.height) {
            // keyboard is hidden
            NSInteger newtextloc = viewBounds.size.height - IOS7_OFFSET - subviewBounds.size.height;
            NSInteger offset = newtextloc - subviewBounds.origin.y;
            displayBounds.size.height += offset;
            subviewBounds.origin.y += offset;
            [[self display] setFrame:displayBounds];
            [[self keyboardView] setFrame:subviewBounds];
        } else {
            NSInteger newtextloc = keyboardBounds.origin.y - subviewBounds.size.height;
            NSInteger offset = newtextloc - subviewBounds.origin.y;
            displayBounds.size.height += offset;
            subviewBounds.origin.y += offset;
            [[self display] setFrame:displayBounds];
            [[self keyboardView] setFrame:subviewBounds];
        }
        // Scroll to the end
        [[self display] scrollRangeToVisible:NSMakeRange([[[self display] text] length], 0)];
        [UIView commitAnimations];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    }
#endif
}

- (IBAction) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self inputField] resignFirstResponder];
}

-(void)textButtonPressed:(id)sender {
    UIButton* button = (UIButton*) sender;
    NSMutableString *buffer = [[NSMutableString alloc]initWithCapacity:10];
    [buffer appendString:[[self inputField] text]];
    [buffer appendString:[[button titleLabel] text]];
    [self.inputField setText:buffer];
}


@end
