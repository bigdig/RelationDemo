//
//  AppDelegate+CustomAppearance.m
//  EDU
//
//  Created by renxingguo on 16/9/7.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "AppDelegate+CustomAppearance.h"
#import "UIColor+RCColor.h"

@implementation AppDelegate (CustomAppearance)


- (void)customAppearance
{
    //tabbar tint color
    UIColor *tintColor = COLOR_LITLE_GREE;
    [[UINavigationBar appearance] setTintColor:tintColor];
    
    //navigation bar
    //    [[UIBarButtonItem  appearance]  setTintColor:[UIColor  redColor]];
    
    //set backgound
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    [[UINavigationBar appearance] setBackgroundImage:[UIColor imageWithColor:COLOR_LITLE_BLUE ] forBarMetrics:(UIBarMetricsDefault)];
    
    [[UINavigationBar appearance] setTranslucent:FALSE];
    
    //[[UINavigationBar appearance] setBackgroundColor:COLOR_LITLE_BLUE];
    
#if 1
    //back button
    //自定义返回按钮
        UIImage *backButtonImage = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    UIImage *backButtonImage = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    //    UIImage *backButtonImage = [UIImage imageNamed:@"nav_back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],UITextAttributeTextColor,
                                               [UIFont fontWithName:@"Helvetica-Bold" size:18.0],NSFontAttributeName,
                                               nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:navbarTitleTextAttributes forState:UIControlStateNormal];
    
#endif
}

@end
