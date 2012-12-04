//
//  DiffFunction.m
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "DiffFunction.h"

@implementation DiffFunction

-(Function*) evaluate {
    self.base = [self.base evaluate];
    return [[self.base differentiate:self.variable] evaluate];
}

@end
