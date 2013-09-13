//
//  Variable.h
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expression.h"

@interface Variable : Expression

@property(strong,nonatomic) NSString* name;

-(Variable*) init:(NSString*) name;

+(Variable*) x;

@end
