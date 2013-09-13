//
//  Expression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/12/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "Variable.h"
#import "Log.h"

@implementation Expression

-(Expression*) evaluate {
    return nil;
}

-(Boolean) equals:(Expression *)another {
    return false;
}

-(Expression*) integrate:(Variable *)v {
    return nil;
}

-(Expression*) differentiate:(Variable *)v {
    return nil;
}

-(void) error:(NSString*) input {
    [Log error:input];
}

-(void) output:(NSString*) input{
    [Log info:input];
}

+(Boolean) equals:(Expression *)left another:(Expression *)right {
    if(left == right)
        return true;
    if(left == nil && right != nil)
        return false;
    return [left equals:right];
}

@end
