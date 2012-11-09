//
//  Constant.m
//  Calculus
//
//  Created by Harper Jiang on 11/6/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Constant.h"
#import "IntegerConstant.h"

@implementation Constant

-(Function*) differentiate:(Variable *)variable {
    return [IntegerConstant ZERO];
}

-(Constant*)add:(Constant *)input {
    return nil;
}

-(Constant*)sub:(Constant *)input {
    return nil;
}
-(Constant*)mul:(Constant *)input {
    return nil;
}
-(Constant*)div:(Constant *)input {
    return nil;
}


@end
