//
//  UITabBarController+HideTabBar.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/22.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UITabBarController+HideTabBar.h"

#define AnimationDuration 0.2f
#define AnimationDelay 0.0f

@implementation UITabBarController (HideTabBar)


- (BOOL)isTabBarHidden
{
    return self.tabBar.frame.origin.y >= self.view.frame.size.height;
}


- (void)hidesTabBar:(BOOL)hidden animated:(BOOL)animated
{
    [self setTabBarHidden:hidden animated:animated];
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    [self setTabBarHidden:tabBarHidden animated:NO];
}

//- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
//{
//    if (hidden == self.isTabBarHidden) return;
//    
//    if (animated) {
//        [UIView animateWithDuration:AnimationDuration delay:AnimationDelay options:UIViewAnimationOptionCurveLinear animations:^{
//            [self adjustSubviewsWithTabBarHidden:hidden];
//        }completion:nil];
//    } else {
//        [self adjustSubviewsWithTabBarHidden:hidden];
//    }
//}

- (void)adjustSubviewsWithTabBarHidden:(BOOL)hidden
{
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]]) {
            tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0.0f : tabBarFrame.size.height);
            view.frame = tabBarFrame;
        } else {
            CGRect containerFrame = view.frame;
            containerFrame.size.height = viewFrame.size.height - (hidden ? 0.0f : tabBarFrame.size.height);
            view.frame = containerFrame;
        }
    }
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    BOOL isHidden = self.tabBarHidden;
    if(hidden == isHidden)
        return;
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        NSLog(@"could not get the container view!");
        return;
    }
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.tabBar.frame = tabBarFrame;
                         transitionView.frame = containerFrame;
                     }
     ];
}

@end
