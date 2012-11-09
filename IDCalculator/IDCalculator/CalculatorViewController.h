//
//  CalculusViewController.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

// TextArea
@property(nonatomic,strong) IBOutlet UITextView* textView;

// Buttons
@property(nonatomic,strong) IBOutlet UIButton* sinButton;
@property(nonatomic,strong) IBOutlet UIButton* cosButton;
@property(nonatomic,strong) IBOutlet UIButton* lnButton;

-(IBAction) sinButtonClicked:(id) sender;
-(IBAction) cosButtonClicked:(id) sender;
-(IBAction) lnButtonClicked:(id) sender;
@end
