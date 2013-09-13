//
//  Expression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data;
@class Variable;

@interface Expression : NSObject

-(Expression*) evaluate;

-(Boolean) equals:(Expression*) another;

-(Expression*) integrate: (Variable*) v;

-(Expression*) differentiate: (Variable*) v;

-(void) error:(NSString*)input;

-(void) output:(NSString*)input;

+(Boolean) equals:(Expression*)left another:(Expression*) right;

@end
