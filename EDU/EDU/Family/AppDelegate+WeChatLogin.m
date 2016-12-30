//
//  AppDelegate+WeChatLogin.m
//  WeBuy
//
//  Created by renxingguo on 16/8/3.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "AppDelegate+WeChatLogin.h"
#import "ReactiveCocoa.h"
#import "FMWtFaUserLoginModel.h"
#import "Toast.h"
#import "FMLoginModel.h"

//#define APP_ID @"wx4868b35061f87885"
//#define APP_SECRET @"64020361b8ec4c99936c0e3999a9f249"

#define APP_ID @"wxf58798795168b0cd"
#define APP_SECRET @"50690ef174b74b40381e0cd34477733c"


@implementation AppDelegate (WeChatLogin)

/**
 * onReq微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用
 * sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
 */
- (void)onReq:(BaseReq *)req {
    
}

/**
 *  如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，
 *  会切到微信终端程序界面。
 */
- (void)onResp:(BaseResp *)resp {
    
    // 处理登录业务逻辑
    FMUserLoginModel *m = [[FMUserLoginModel alloc] init];
    RACCommand *loginCommand = m.command;
    [loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        //
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
        }
        else
        {
            //bind telephone
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRegisterViewController_Bind"];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:ctl];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                ;
            }];
        }
    }];
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode == 0) { // 用户同意
        NSLog(@"errCode = %d", aresp.errCode);
        NSLog(@"code = %@", aresp.code);
        
        // 获取access_token
        //      格式：https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
        NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", APP_ID, APP_SECRET, aresp.code];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString* openid = [dic objectForKey:@"openid"]; // 初始化
                    NSString* access_token = [dic objectForKey:@"access_token"];
                    //                    NSLog(@"openid = %@", _openid);
                    //                    NSLog(@"access = %@", [dic objectForKey:@"access_token"]);
                    NSLog(@"dic = %@", dic);
                    
                    [Configuration Instance].wxopenid = openid;
                    [Configuration Instance].wxaccess_token = access_token;
                    
                    [loginCommand execute:nil];
                }
            });
        });
    } else if (aresp.errCode == -2) {
        NSLog(@"用户取消登录");
    } else if (aresp.errCode == -4) {
        NSLog(@"用户拒绝登录");
    } else {
        NSLog(@"errCode = %d", aresp.errCode);
        NSLog(@"code = %@", aresp.code);
    }
    
}


@end
