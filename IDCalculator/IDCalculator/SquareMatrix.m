//
//  SquareMatrix.m
//  IDCalculator
//
//  Created by Harper Jiang on 11/10/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquareMatrix.h"

@implementation SquareMatrix

-(SquareMatrix*) init:(NSArray*)data size:(NSInteger) size {
    self = [super init];
    if(self) {
        [self setData:data];
        [self setSize:size];
    }
    return self;
}

-(NSInteger) m {
    return self.size;
}

-(void) setM:(NSInteger)m {

}

-(NSInteger) n {
    return self.size;
}

-(void) setN:(NSInteger)n{
    
}

@end
