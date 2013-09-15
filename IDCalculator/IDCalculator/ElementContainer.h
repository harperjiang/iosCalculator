//
//  ElementContainer.h
//  IDCalculator
//
//  Created by Harper Jiang on 9/14/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "Element.h"

@interface ElementContainer : Element

@property(nonatomic,strong) NSMutableArray* objects;

-(void) addElement:(Element*) obj;
-(void) removeElement:(Element*) obj;

@end
