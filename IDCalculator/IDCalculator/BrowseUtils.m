//
//  BrowseUtils.m
//  IDCalculator
//
//  Created by Harper Jiang on 9/20/13.
//  Copyright (c) 2013 Harper Jiang. All rights reserved.
//

#import "BrowseUtils.h"
#import "ViewUtils.h"
#import "Canvas2DView.h"

@implementation BrowseUtils

+(Environment*) findGraphEnvironment {
    Canvas2DView* view = (Canvas2DView*)[ViewUtils getViewByClass:[Canvas2DView class]];
    return view.viewPort.environment;
}

@end
