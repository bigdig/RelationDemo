//
//  UIViewController+Share.m
//  EDU
//
//  Created by renxingguo on 16/9/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "UIViewController+Share.h"
#import "BCWXShareActivity.h"

@implementation UIViewController (Share)

- (void)loginAndGetUserInfo
{
    [BCWXLoginProvider loginWithCompleteBlock:^(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg) {
        if (suc)
        {
            [BCWXLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, BCWXUserInfo *userInfo) {
                if (suc)
                {
                    //use userInfo
                }
            }];
        }
    }];
}

- (void)share
{
    [BCWXShareProvider shareWebPage:BCWX_SESSION
                          withTitle:@"分享到微信"
                               text:@"内容"
                              image:[UIImage imageNamed:@"thumbImage"]
                             webUrl:@"github.com"
                           complete:^(BOOL suc, NSString *errMsg) {
                               //to do after share
                           }];
}

- (void)shareOnActivityController
{
    BCWXSessionActivity *item = [[BCWXSessionActivity alloc] init];
    
    item.title = @"title";
    item.text = @"content";
    item.thumbImage = [UIImage new];
    item.webUrl = @"youdao.com";
    [item setCompleteBlock:^(BOOL suc, NSString *errMsg) {
        //to do after share
    }];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[item.title, item.webUrl, item.thumbImage] applicationActivities:@[item]];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
