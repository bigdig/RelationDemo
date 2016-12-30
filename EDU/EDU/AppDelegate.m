//
//  AppDelegate.m
//  EDU
//
//  Created by renxingguo on 16/8/29.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AppDelegate+CustomAppearance.h"
#import "NewFeatureViewController.h"
#import "BCWXSocialHandler.h"

#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <WXApi.h>
#import "AppDelegate+WeChatLogin.h"

@interface AppDelegate ()<NSURLSessionDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self customAppearance];
    //[Configuration Instance].cookie = 0;
    
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"585c9604f43e4863d10029c4";
    //UMConfigInstance.secret = @"secretstringaldfkals";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
    
    [[TencentOAuth alloc]initWithAppId:@"1105703581" andDelegate:nil];
    /**
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105703581"  appSecret:@"KoQZJZK2RBCljHTC" redirectURL:@"http://mobile.umeng.com/social"];
     */
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LOGIN_SUCCESS" object:nil] subscribeNext:^(id x) {
        //[[UIApplication sharedApplication].keyWindow.rootViewController.view endEditing:YES];
        UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRelationViewController"];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:ctl];
        self.window.rootViewController = nav;
    }];
    
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LOGOUT_SUCCESS" object:nil] subscribeNext:^(id x) {

        UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"WXLoginViewController"];
        
        self.window.rootViewController = ctl;
    }];
    
    //读取沙盒数据
    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"is_first"];
    NSString *value = [settings1 objectForKey:key1];
    
    value = @"SKIPP";
    if (!value)  //如果没有数据
    {
        self.window.rootViewController = [[NewFeatureViewController alloc] init];
    }
    else
    {
        /**
        RootTabBarViewController *ctl = [[UIStoryboard storyboardWithName:@"firstpage" bundle:nil] instantiateViewControllerWithIdentifier:@"RootTabBarViewController"];
        self.window.rootViewController = ctl;
         */
        if ([[Configuration Instance] isCookie])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
        }
        else
        {
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"WXLoginViewController"];
            self.window.rootViewController = ctl;
        }

    }
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"SwitchRootViewControllerNotification" object:nil] subscribeNext:^(id x) {
        if ([[Configuration Instance] isCookie])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
        }
        else
        {
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"WXLoginViewController"];
            self.window.rootViewController = ctl;
        }
        [[NSUserDefaults standardUserDefaults] setValue:@"done" forKey:@"is_first"];

    }];
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceTokenStringKEY"])
        
    {
        [[NSUserDefaults standardUserDefaults] setObject:[UIDevice currentDevice].identifierForVendor.UUIDString forKey:@"DeviceTokenStringKEY"];
        
    }
    
    [[BCWXSocialHandler sharedInstance] setWXAppId:@"wx961f9b27189265b8" appSecret:@"1ca695652c8fd494e7bf90c8bfd0140e"];
    
    
    //向微信注册
    [WXApi registerApp:@"wxf58798795168b0cd"]; // 注意这里不要写错！（写错后无法获取授权，停留在登录界面等待）
    //    [WXApi isWXAppInstalled]; // 检查用户手机是否已安装微信客户端，对未安装的用户隐藏微信登录按钮，只提供其他登录方式（比如手机号注册登录、游客登录等）
    return YES;
}

// openURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

// handleURL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceTokenStr = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", deviceTokenStr);
    //save device token
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"DeviceTokenStringKEY"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    sleep(1);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"接收到服务器响应");
    //注意：这里需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
    //默认是取消
    /**
     NSURLSessionResponseCancel = 0,            默认的处理方式，取消
     NSURLSessionResponseAllow = 1,             接收服务器返回的数据
     NSURLSessionResponseBecomeDownload = 2,    变成一个下载请求
     NSURLSessionResponseBecomeStream           变成一个流
     */
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"获取到服务段数据");
    NSLog(@"%@",[self jsonToDictionary:data]);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"请求完成");
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"证书认证");
    /**
    //直接验证服务器是否被认证（serverTrust），这种方式直接忽略证书验证，直接建立连接，但不能过滤其它URL连接，可以理解为一种折衷的处理方式，实际上并不安全，因此不推荐。
    SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    return [[challenge sender] useCredential: [NSURLCredential credentialForTrust: serverTrust]
                  forAuthenticationChallenge: challenge];
    */
    
    if ([[[challenge protectionSpace] authenticationMethod] isEqualToString: NSURLAuthenticationMethodServerTrust]) {
        do
        {
            SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
            NSCAssert(serverTrust != nil, @"serverTrust is nil");
            if(nil == serverTrust)
                break; /* failed */
            /**
             *  导入多张CA证书（Certification Authority，支持SSL证书以及自签名的CA），请替换掉你的证书名称
             */
            NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//自签名证书
            NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
            
            NSCAssert(caCert != nil, @"caCert is nil");
            if(nil == caCert)
                break; /* failed */
            
            SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
            NSCAssert(caRef != nil, @"caRef is nil");
            if(nil == caRef)
                break; /* failed */
            
            //可以添加多张证书
            NSArray *caArray = @[(__bridge id)(caRef)];
            
            NSCAssert(caArray != nil, @"caArray is nil");
            if(nil == caArray)
                break; /* failed */
            
            //将读取的证书设置为服务端帧数的根证书
            OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
            NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
            if(!(errSecSuccess == status))
                break; /* failed */
            
            SecTrustResultType result = -1;
            //通过本地导入的证书来验证服务器的证书是否可信
            status = SecTrustEvaluate(serverTrust, &result);
            if(!(errSecSuccess == status))
                break; /* failed */
            NSLog(@"stutas:%d",(int)status);
            NSLog(@"Result: %d", result);
            
            BOOL allowConnect = (result == kSecTrustResultUnspecified) || (result == kSecTrustResultProceed);
            if (allowConnect) {
                NSLog(@"success");
            }else {
                NSLog(@"error");
            }
            
            /* kSecTrustResultUnspecified and kSecTrustResultProceed are success */
            if(! allowConnect)
            {
                break; /* failed */
            }
            
#if 0
            /* Treat kSecTrustResultConfirm and kSecTrustResultRecoverableTrustFailure as success */
            /*   since the user will likely tap-through to see the dancing bunnies */
            if(result == kSecTrustResultDeny || result == kSecTrustResultFatalTrustFailure || result == kSecTrustResultOtherError)
                break; /* failed to trust cert (good in this case) */
#endif
            
            // The only good exit point
            NSLog(@"信任该证书");
            
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
            return [[challenge sender] useCredential: credential
                          forAuthenticationChallenge: challenge];
            
        }
        while(0);
    }
    
    // Bad dog
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,credential);
    return [[challenge sender] cancelAuthenticationChallenge: challenge];
}


- (NSDictionary *)jsonToDictionary:(NSData *)jsonData {
    NSError *jsonError;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
    return resultDic;
}

@end
