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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self customAppearance];
    [Configuration Instance].cookie = 0;
    
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"581aef3d6e27a42e19001a61";
    //UMConfigInstance.secret = @"secretstringaldfkals";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
    
    [[TencentOAuth alloc]initWithAppId:@"1105703581" andDelegate:nil];
    /**
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105703581"  appSecret:@"KoQZJZK2RBCljHTC" redirectURL:@"http://mobile.umeng.com/social"];
     */
    //TO_UPDATE_PROFILE
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"TO_UPDATE_PROFILE" object:nil] subscribeNext:^(id x) {
        UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRegisterViewController"];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:ctl];
        self.window.rootViewController = nav;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LOGIN_SUCCESS" object:nil] subscribeNext:^(id x) {
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
    [WXApi registerApp:@"wx4868b35061f87885"]; // 注意这里不要写错！（写错后无法获取授权，停留在登录界面等待）
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

@end
