//
//  Data.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "Number.h"

@interface Data : Expression

-(Data*) add:(Data*)another;
-(Data*) sub:(Data*)another;
-(Data*) mul:(Data*)another;
-(Data*) div:(Data*)another;

@end
