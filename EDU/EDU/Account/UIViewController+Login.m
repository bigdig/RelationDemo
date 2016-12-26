//
//  UIViewController+Login.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/14.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UIViewController+Login.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@implementation UIViewController (Login)

- (BOOL)isLogin
{
    if ([[Configuration Instance] isCookie])
    {
        return TRUE;
    }
    else
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"V2LoginStoryboard" bundle:nil];
        UINavigationController *nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginRootNavigation"];
        UIViewController *rootvc = [[UIApplication sharedApplication] delegate].window.rootViewController;
        [rootvc presentViewController:nav animated:YES completion:^{
            ;
        }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LOGIN_SUCCESS" object:nil] subscribeNext:^(id x) {
            //
            /**
            if ([[Configuration Instance].school length]==0 || [[Configuration Instance].school length]==0) {
                [nav dismissViewControllerAnimated:YES completion:^{
                    UINavigationController *nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewControllerNav"];
                    UIViewController *rootvc = [[UIApplication sharedApplication] delegate].window.rootViewController;
                    [rootvc presentViewController:nav animated:YES completion:^{
                        ;
                    }];
                }];
            }
             */
            [nav dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"SAVE_PROFILE_SUCCESS" object:nil] subscribeNext:^(id x) {
            //
            [nav dismissViewControllerAnimated:YES completion:nil];
        }];
        
        return FALSE;
    }
}

@end
