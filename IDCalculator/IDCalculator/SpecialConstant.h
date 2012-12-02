//
//  SpecialConstant.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"


@interface SpecialConstant : Constant

@property(nonatomic,readonly,strong) NSString* name;

+(SpecialConstant*) PI;
+(SpecialConstant*) E;

@end
