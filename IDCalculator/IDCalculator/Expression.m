//
//  Expression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "IDCConsole.h"

@implementation Expression

-(Data*) evaluate {
    return nil;
}

-(void) error:(NSString*) input {
    [[IDCConsole instance] error:input];
}

-(void) output:(NSString*) input{
    [[IDCConsole instance] output:input];
}

@end
