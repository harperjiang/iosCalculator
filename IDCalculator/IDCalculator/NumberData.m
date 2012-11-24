//
//  NumberData.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "NumberData.h"
#import "IDCConsole.h"

@implementation NumberData

-(NumberData*) init:(Number*) num {
    self = [super init];
    if(self) {
        [self setNumber:num];
    }
    return self;
}

-(NSString*) description {
    return [[self number] description];
}

-(Data*) add:(Data*) another {
    if([another class] == [NumberData class]) {
        return [[NumberData alloc] init:[[self number] add:[(NumberData*)another number]]];
    } else {
        [[IDCConsole instance] error:@"Adding number with non-number"];
        return nil;
    }
}


-(Data*) sub:(Data*) another {
    if([another class] == [NumberData class]) {
        return [[NumberData alloc] init:[[self number] sub:[(NumberData*)another number]]];
    } else {
        [[IDCConsole instance] error:@"Subtracting number with non-number"];
        return nil;
    }
    return nil;
}

-(Data*) mul:(Data*) another {
    if([another class] == [NumberData class]) {
        return [[NumberData alloc] init:[[self number] mul:[(NumberData*)another number]]];
    }
    else {
        return [another mul:self];
    }
}

-(Data*) div:(Data*) another {
    if([another class] == [NumberData class]) {
        return [[NumberData alloc] init:[[self number] div:[(NumberData*)another number]]];
    } else {
        [[IDCConsole instance] error:@"Dividing number with non-number"];
        return nil;
    }
}

@end
