//
//  ValueExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/13/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ValueExpression.h"

@implementation ValueExpression

-(ValueExpression*) init:(id)value {
    self = [super init];
    if(self) {
        [self setValue:value];
    }
    return self;
}

-(id) evaluate {
    return [self value];
}

@end
