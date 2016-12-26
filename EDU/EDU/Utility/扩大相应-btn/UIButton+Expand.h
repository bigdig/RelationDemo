//
//  UIButton+Expand.h
//  峡谷寻宝
//
//  Created by wangning on 15/10/28.
//  Copyright © 2015年 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (Expand)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
