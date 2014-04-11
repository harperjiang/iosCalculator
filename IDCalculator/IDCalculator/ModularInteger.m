//
//  ModularInteger.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/25/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "ModularInteger.h"

@implementation ModularInteger

-(ModularInteger*) init: (NSInteger)value mod:(NSInteger)mod{
    self = [super init];
    if(self){
        while(value<0)
            value+= mod;
        [self setValue:value%mod];
        [self setMod:mod];
    }
    return self;
}

-(Number*) add:(Number *)input {
    if([input class] == [ModularInteger class]) {
        ModularInteger* mi = (ModularInteger*)input;
        if(mi.mod != self.mod)
            return nil;
        NSInteger value = (self.value + mi.value) % self.mod;
        return [[ModularInteger alloc] init:value mod:self.mod];
    }
    return nil;
}

-(Number*) sub:(Number *)input {
    if([input class] == [ModularInteger class]) {
        ModularInteger* mi = (ModularInteger*)input;
        if(self.mod != mi.mod)
            return nil;
        NSInteger value = (self.value - mi.value) % self.mod;
        return [[ModularInteger alloc] init:value mod:self.mod];
    }
    return nil;
}

-(Number*) mul:(Number *)input {
    if([input class] == [ModularInteger class]) {
        ModularInteger* mi = (ModularInteger*)input;
        if(self.mod != mi.mod)
            return nil;
        NSInteger value = (self.value * mi.value) % self.mod;
        return [[ModularInteger alloc] init: value mod:self.mod];
    }
    return nil;
}

-(Number*) div:(Number *)input {
    if([input class] == [ModularInteger class]) {
        ModularInteger* mi = (ModularInteger*)input;
        if(mi.mod != self.mod)
            return nil;
        ModularInteger* inv = [ModularInteger inverse:mi];
        if(nil != inv)
            return (Number*)[self mul:inv];
        return nil;
    }
    return nil;
}

-(ModularInteger*) modInverse {
    return [ModularInteger inverse:self];
}

-(ModularInteger*) modExp:(NSInteger)exp {
    NSInteger max = 0;
    while(powl(2, max)<=exp)
        max++;
    NSMutableArray* valueArray = [[NSMutableArray alloc] init];
    [valueArray insertObject:self atIndex:0];
    for(int i = 1; i < max; i++) {
        ModularInteger* prev = (ModularInteger*)[valueArray objectAtIndex:i-1];
        [valueArray insertObject:[prev mul:prev] atIndex:i];
    }
    ModularInteger* current = [[ModularInteger alloc]init:1 mod:self.mod];
    for(int i = 0 ; i < max;i++) {
        if(1<<i & exp)
            current = (ModularInteger*)[current mul:(ModularInteger*)[valueArray objectAtIndex:i]];
    }
    return current;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%d",[self value]];
}

+(ModularInteger*) inverse:(ModularInteger*) input {
    Pulverizer* p = [[Pulverizer alloc] init:input.mod b:input.value];
    while(p.b != 0 && p.b != 1) {
        [p round];
    }
    if(p.b == 0)
        return nil;
    return [[ModularInteger alloc] init:p.y2 mod:input.mod];
}

@end


@implementation Pulverizer

-(Pulverizer*) init:(NSInteger)a b:(NSInteger)b {
    self = [super init];
    if(self) {
        [self setA: a];
        [self setB: b];
        [self setX1:1];
        [self setY1:0];
        [self setX2:0];
        [self setY2:1];
    }
    return self;
}

-(void) round {
    [self setQuotient: self.a/self.b];
    [self setRemaining: self.a%self.b];
    [self setA:self.b];
    [self setB:self.remaining];
    NSInteger oldx1 = self.x1;
    NSInteger oldy1 = self.y1;
    [self setX1:self.x2];
    [self setY1:self.y2];
    [self setX2:oldx1 - self.quotient*self.x1];
    [self setY2:oldy1 - self.quotient*self.y1];
}

-(void) calculate {
    while(self.b != 0 && self.b != 1) {
        [self round];
    }
}
@end
