//
//  FuncExpression.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "FuncExpression.h"
#import "Variable.h"
#import "IDCConsole.h"
#import "Matrix.h"
#import "Vector.h"
#import "Integer.h"
#import "ModularInteger.h"

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
    Expression* val = [[expList get:0] evaluate];
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
    Expression* val = [[expList get:0] evaluate];
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
    Expression* val = [[expList get:0] evaluate];
    if([val isKindOfClass:[Number class]]) {
        Number* nd = (Number*)val;
        if([nd class] == [Integer class]) {
            NSInteger intval = [(Integer*)nd value];
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

@implementation ModExpFuncCallback

-(ModExpFuncCallback*) init {
    self = [super init];
    if(self) {
        [self setParamCount:3];
    }
    return self;
}

-(Boolean) check:(ExpressionList*) expList {
    if(![super check:expList]) {
        [self error:@"Incorrect Param Count"];
        return false;
    }
    // Parameter type check
    /*
    if(!([[[expList get:0]]isKindOfClass:[Integer class]]
    &&[[[expList get:1] class]isKindOfClass:[Integer class]]
         &&[[[expList get:2] class]isKindOfClass:[Integer class]])) {
        [self error:@"Incorrect Param Type"];
        return false;
    }*/
    return true;
}

-(Data*) calculate:(ExpressionList *)expList {
    Integer* a = (Integer*)[expList get:0];
    Integer* e = (Integer*)[expList get:1];
    Integer* p = (Integer*)[expList get:2];
    ModularInteger* mi = [[ModularInteger alloc] init:a.value mod:p.value];
    return [mi modExp:e.value];
}

@end

@implementation CRTFuncCallback

-(CRTFuncCallback*) init {
    self = [super init];
    if(self) {
        [self setParamCount:4];
    }
    return self;
}

-(Boolean) check:(ExpressionList*) expList {
    if([expList count] != 3 && [expList count] != 4) {
        [self error:@"Incorrect Param Count"];
        return false;
    }
    return true;
}

-(Data*) calculate:(ExpressionList *)expList {
    if([expList count] == 3) {
        Integer* a = (Integer*)[expList get:0];
        Integer* b = (Integer*)[expList get:1];
        Integer* v = (Integer*)[expList get:2];
        NSMutableArray* array = [[NSMutableArray alloc]init];
        [array insertObject:[[ModularInteger alloc] init: v.value mod:a.value] atIndex:0];
        [array insertObject:[[ModularInteger alloc] init: v.value mod:b.value] atIndex:1];
        Matrix* m = [[Matrix alloc] init:array m:1 n:2];
        return m;
    } else {
        Integer* a1 = (Integer*)[expList get:0];
        Integer* a = (Integer*)[expList get:1];
        Integer* b1 = (Integer*)[expList get:2];
        Integer* b = (Integer*)[expList get:3];
        NSInteger max = MAX(a.value,b.value);
        NSInteger min = MIN(a.value,b.value);
        Pulverizer* pul = [[Pulverizer alloc] init:max b:min];
        [pul calculate];
        if(pul.b == 0)
            return nil;
        NSInteger p = min*pul.y2;
        NSInteger q = max*pul.x2;
        NSInteger a1v = (max == a.value)?a1.value:b1.value;
        NSInteger b1v = (max == a.value)?b1.value:a1.value;
        return [[ModularInteger alloc] init:p*a1v+q*b1v mod:a.value*b.value];
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
        [callbacks setObject:[[InverseFunction alloc] init] forKey:@"inverse"];
        [callbacks setObject:[[ModExpFuncCallback alloc] init] forKey:@"modexp"];
        [callbacks setObject:[[CRTFuncCallback alloc] init] forKey:@"crt"];
    }
}

-(FuncExpression*) init:(Variable *)name params:(ExpressionList *)ps {
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
