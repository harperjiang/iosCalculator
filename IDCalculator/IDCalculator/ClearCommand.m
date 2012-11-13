//
//  ClearCommand.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/11/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "ClearCommand.h"

@implementation ClearCommand

-(void) execute{
    [[[IDCConsole instance] buffer] setString:nil];
}

@end
