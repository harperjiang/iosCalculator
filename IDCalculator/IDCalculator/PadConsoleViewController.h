//
//  PadConsoleViewController.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/28/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadConsoleViewController : UIViewController

@property(nonatomic,strong) IBOutlet UITextField *inputField;
@property(nonatomic,strong) IBOutlet UITextView *display;
@property(nonatomic,strong) IBOutlet UIView* keyboardView;

- (IBAction) editingDone:(id) sender;
- (IBAction) textButtonPressed:(id) sender;
@end
