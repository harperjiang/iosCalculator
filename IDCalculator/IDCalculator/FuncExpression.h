//
//  FuncExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/24/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#import "Expression.h"
#import "Variable.h"
#import "ExpressionList.h"

@interface FuncCallback : NSObject

@property NSInteger paramCount;

-(Data*) execute:(ExpressionList*) expList;
-(void) error:(NSString*)input;
-(void) output:(NSString*)input;

@end

@interface InverseFunction : FuncCallback

@end

@interface TransposeFunction : FuncCallback

@end

@interface IdentityFunction : FuncCallback

@end

@interface PowerFuncCallback :  FuncCallback

@end

@interface ModExpFuncCallback : FuncCallback

@end

@interface CRTFuncCallback : FuncCallback

@end

@interface FuncExpression : Expression

@property(nonatomic,strong) Variable* name;
@property(nonatomic,strong) ExpressionList* params;

-(FuncExpression*) init:(Variable*) name params:(ExpressionList*)ps;

@end
