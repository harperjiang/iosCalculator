//
//  Function.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;

@interface Function : NSObject

-(Function*) evaluate;

-(Function*) differentiate:(Variable*) variable;
-(Function*) integrate:(Variable*) variable;

@end
