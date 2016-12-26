//
//  UIScrollView+Scroll.m
//  EDU
//
//  Created by renxingguo on 16/9/23.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "UIScrollView+Scroll.h"
#include <objc/runtime.h>

static char kSignalKey;

@implementation UIScrollView (Scroll)

- (void)setScrollDelegate:(id)scrollDelegate
{
    objc_setAssociatedObject(self, &kSignalKey, scrollDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id)scrollDelegate
{
    return objc_getAssociatedObject(self, &kSignalKey);
}


@end
