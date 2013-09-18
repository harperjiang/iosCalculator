//
//  FunctionGraph.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/17/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Element.h"
#import "Function.h"

@interface FunctionGraph : Element

@property(nonatomic,strong) Function* function;

@end
