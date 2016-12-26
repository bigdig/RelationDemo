//
//  UITabBarController+HideTabBar.h
//  DressingCollection
//
//  Created by renxingguo on 15/9/22.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (HideTabBar)

@property (assign, nonatomic, getter = isTabBarHidden) BOOL tabBarHidden;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)hidesTabBar:(BOOL)hidden animated:(BOOL)animated;

@end
