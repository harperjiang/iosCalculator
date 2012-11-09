//
//  Constant.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"

@interface Constant : Function

-(Constant*)add:(Constant*)input;
-(Constant*)sub:(Constant*)input;
-(Constant*)mul:(Constant*)input;
-(Constant*)div:(Constant*)input;

@end
