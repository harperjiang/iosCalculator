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
-(IBAction) numberButtonClicked:(id) sender;
-(IBAction) powerButtonClicked:(id) sender;
-(IBAction) integrateButtonClicked:(id) sender;
-(IBAction) differentiateButtonClicked:(id) sender;
-(IBAction) lpButtonClicked:(id) sender;
-(IBAction) rpButtonClicked:(id) sender;
-(IBAction) dxButtonClicked:(id) sender;
-(IBAction) xButtonClicked:(id) sender;
-(IBAction) eButtonClicked:(id) sender;
-(IBAction) piButtonClicked:(id) sender;
-(IBAction) oprButtonClicked:(id) sender;
-(IBAction) backspaceButtonClicked:(id) sender;
-(IBAction) equalButtonClicked:(id) sender;
@end
