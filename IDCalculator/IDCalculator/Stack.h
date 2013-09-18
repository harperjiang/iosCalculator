//
//  Stack.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/15/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property(nonatomic,strong) NSMutableArray* content;
@property(nonatomic) NSInteger pointer;

-(void) push:(id) element;
-(id) pop;
-(id) peek;

@end
