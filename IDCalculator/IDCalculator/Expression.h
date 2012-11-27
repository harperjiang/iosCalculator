//
//  Expression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data;

@interface Expression : NSObject

-(Data*) evaluate;
-(void) error:(NSString*)input;
-(void) output:(NSString*)input;
@end
