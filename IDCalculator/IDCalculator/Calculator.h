//
//  Calculator.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/2/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

+(Calculator*) instance;

-(NSString*) calculate:(NSString*) text;

@end
