//
//  UIButton+ZanAnimation.m
//  EDU
//
//  Created by renxingguo on 16/9/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "UIButton+ZanAnimation.h"

@implementation UIButton (ZanAnimation)

- (void)zanAnimation {
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAni.duration = 0.5f;
    keyframeAni.values = @[ @(0.1), @(1.5), @(1.0) ];
    keyframeAni.keyTimes = @[ @(0), @(0.8), @(1) ];
    keyframeAni.calculationMode = kCAAnimationLinear;
    [self.layer addAnimation:keyframeAni forKey:@"like"];
}

@end
