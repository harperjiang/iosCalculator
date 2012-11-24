//
//  Number.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Number : NSObject

-(Number*)add:(Number*)input;
-(Number*)sub:(Number*)input;
-(Number*)mul:(Number*)input;
-(Number*)div:(Number*)input;

@end
