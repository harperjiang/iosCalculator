//
//  ConsoleViewController.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/9/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsoleViewController : UIViewController

@property(nonatomic,strong) IBOutlet UITextField *inputField;
@property(nonatomic,strong) IBOutlet UITextView *display;

- (IBAction) editingDone:(id) sender;
@end
