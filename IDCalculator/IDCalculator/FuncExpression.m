//
//  FuncExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FuncExpression.h"
#import "ConsoleIdentifier.h"
#import "IDCConsole.h"
#import "Matrix.h"
#import "SquareMatrix.h"
#import "Vector.h"
#import "NumberData.h"
#import "Integer.h"

@implementation FuncCallback

-(Data*) execute:(ExpressionList *)expList{
    if([self check:expList]) {
        return [self calculate:expList];
    }
    return nil;
}
    
-(Boolean) check:(ExpressionList*) expList {
    if([expList count] != self.paramCount) {
        [self error:@"Incorrect Param Count"];
        return false;
    }
    return true;
}

-(Data*) calculate:(ExpressionList*) expList {
    return nil;
}

-(void) error:(NSString *)input {
    [[IDCConsole instance] error:input];
}

-(void) output:(NSString *)input {
    [[IDCConsole instance] output:input];
}
@end

@implementation TransposeFunction

-(TransposeFunction*) init {
    self = [super init];
    if(self) {
        [self setParamCount:1];
    }
    return self;
}

-(Data*) calculate:(ExpressionList *)expList {
    Data* val = [[expList get:0] evaluate];
    if([val isKindOfClass:[Matrix class]]) {
        return [(Matrix*)val transpose];
    } else {
        [self error:@"Input is not a matrix"];
        return nil;
    }
}

@end

@implementation InverseFunction

-(InverseFunction*) init {
    self = [super init];
    if(self) {
        [self setParamCount:1];
    }
    return self;
}

-(Data*) calculate:(ExpressionList *)expList {
    Data* val = [[expList get:0] evaluate];
    if([val class] == [Matrix class]) {
        return [(Matrix*)val inverse];
    } else {
        [self error:@"Input is not a square matrix"];
        return nil;
    }
}

@end

@implementation IdentityFunction

-(IdentityFunction*) init {
    self = [super init];
    if(self) {
        [self setParamCount:1];
    }
    return self;
}

-(Data*) calculate:(ExpressionList *)expList {
    Data* val = [[expList get:0] evaluate];
    if([val class] == [NumberData class]) {
        NumberData* nd = (NumberData*)val;
        if([[nd number] class] == [Integer class]) {
            NSInteger intval = [(Integer*)[nd number] value];
            return [Matrix identity:intval];
        } else {
            [self error:@"Parameter is not an integer"];
            return nil;
        }
    } else {
        [self error:@"Parameter is not an integer"];
        return nil;
    }
}

@end

@implementation PowerFuncCallback

-(PowerFuncCallback*) init {
    self = [super init];
    if(self) {
        [self setParamCount:2];
    }
    return self;
}

-(Boolean) check:(ExpressionList*) expList {
    if([expList count] >= self.paramCount) {
        [self error:@"Incorrect Param Count"];
        return false;
    }
    return true;
}

-(Data*) calculate:(ExpressionList *)expList {
    if([expList count] == 1) {
        // e^n
        return nil;
    } else {
        // a^b
        return nil;
    }
}
@end

@implementation FuncExpression

static NSMutableDictionary* callbacks;

+(void) initialize {
    if([self class] == [FuncExpression class]) {
        // Initialize Callbacks
        callbacks = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        [callbacks setObject:[[TransposeFunction alloc] init] forKey:@"transpose"];
        [callbacks setObject:[[IdentityFunction alloc] init] forKey:@"identity"];
        [callbacks setObject:[[InverseFunction alloc] init] forKey:@"inv"];
    }
}

-(FuncExpression*) init:(ConsoleIdentifier *)name params:(ExpressionList *)ps {
    self = [super init];
    if(self) {
        [self setName:name];
        [self setParams:ps];
    }
    return self;
}

-(Data*) evaluate {
    FuncCallback* callback = [callbacks objectForKey:[[self name] name]];
    if(nil != callback) {
        return [callback execute:[self params]];
    }
    [self error:[NSString stringWithFormat:@"Invalid Function %@",[[self name]name]]];
    return nil;
}

@end
