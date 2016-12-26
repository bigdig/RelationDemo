//
//  RootTabBarViewController.m
//  DressingCollection
//
//  Created by renxingguo on 15/11/6.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "UIViewController+Login.h"
#import "UIViewController+Share.h"
#import "JSONHTTPClient.h"
#import "Toast.h"
#import "ZYShareView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface RootTabBarViewController ()<UITabBarControllerDelegate,UIPopoverPresentationControllerDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //selected tint color
    [[UITabBar appearance] setTintColor:COLOR_LITLE_GREE];
    
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    @weakify(self);
    //hack add search and menu
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        __block UIViewController *obj = vc;
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = vc;
            obj = [nav.childViewControllers firstObject];
        }
//        else
//        {
//            //第四项是controller + (nav + controller_i_want)
//            [obj.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull v, NSUInteger idx, BOOL * _Nonnull stop) {
//                //xxxx
//                if ([v isKindOfClass:[UINavigationController class]]) {
//                    UINavigationController *nav = v;
//                    obj = [nav.childViewControllers firstObject];
//                }
//            }];
//        }
        
        //show tabbar
//         [[[obj rac_signalForSelector:@selector(viewDidAppear:)] deliverOnMainThread] subscribeNext:^(id x) {
//             if (obj.tabBarController.tabBar.isHidden) {
//                 obj.tabBarController.tabBar.hidden = FALSE;
//                 [obj.view layoutSubviews];
//             }
//             //[obj.customTabBarController hidesTabBar:FALSE animated:YES];
//         }];
//        
//        [[[obj rac_signalForSelector:@selector(viewDidDisappear:)] deliverOnMainThread] subscribeNext:^(id x) {
//            if (!obj.tabBarController.tabBar.isHidden) {
//                obj.tabBarController.tabBar.hidden = TRUE;
//            }
//            //[obj.customTabBarController hidesTabBar:FALSE animated:YES];
//        }];

        [[[obj rac_signalForSelector:@selector(viewWillAppear:)] deliverOnMainThread] subscribeNext:^(id x) {
            if (obj.tabBarController.tabBar.isHidden) {
                obj.tabBarController.tabBar.hidden = FALSE;
                [obj.view layoutSubviews];
            }
            //[obj.customTabBarController hidesTabBar:FALSE animated:YES];
        }];
        
        [[[obj rac_signalForSelector:@selector(viewWillDisappear:)] deliverOnMainThread] subscribeNext:^(id x) {
            if (!obj.tabBarController.tabBar.isHidden && [obj.navigationController.viewControllers count]!=1) {
                obj.tabBarController.tabBar.hidden = TRUE;
            }
            //[obj.customTabBarController hidesTabBar:FALSE animated:YES];
        }];
        
        
        [[[obj rac_signalForSelector:@selector(viewDidLoad)] deliverOnMainThread] subscribeNext:^(id x) {
            
            //share button
            UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fenxiang"] style:UIBarButtonItemStylePlain target:nil action:nil];
            shareButton.tintColor = [UIColor whiteColor];
            shareButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                [self shareAction];
                return [RACSignal empty];
            }];
            
            
            UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
            searchButton.tintColor = [UIColor whiteColor];
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
            menuButton.tintColor = [UIColor whiteColor];
            
            searchButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                UIViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"PureSearchViewController"];
                [obj.navigationController pushViewController:controller animated:YES];
                return [RACSignal empty];
            }];
            
            menuButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                UIViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"DBMenuViewController"];
                [[controller rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)] subscribeNext:^(RACTuple *x) {
                    [controller dismissViewControllerAnimated:FALSE completion:^{}];
                    NSIndexPath *indexPath = x.second;
                    
                    if (indexPath.row==0) {
                        //share
                        //[self ShareOne];
                    }
                }];
                
                controller.modalPresentationStyle = UIModalPresentationPopover;
                controller.popoverPresentationController.barButtonItem = obj.navigationItem.rightBarButtonItem;  //rect参数是以view的左上角为坐标原点（0，0）
                controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUnknown; //箭头方向,如果是baritem不设置方向，会默认up，up的效果也是最理想的
                controller.popoverPresentationController.delegate = self;
                [obj presentViewController:controller animated:YES completion:nil];
                return [RACSignal empty];
            }];
            
            //obj.navigationItem.rightBarButtonItems = @[menuButton,searchButton];
            if (idx==0) {
                UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo_title"] style:UIBarButtonItemStylePlain target:nil action:nil];
                shareButton.tintColor = [UIColor whiteColor];
                [shareButton setWidth:70.0];
                shareButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    //
                    @strongify(self);
//                    [self shareAction];
                    return [RACSignal empty];
                }];
                
                obj.navigationItem.rightBarButtonItems = @[shareButton];
            }
            else
            {
                obj.navigationItem.rightBarButtonItems = @[shareButton,searchButton];
            }
            
        }];
        
    }];
    
    // show first tab after logout trigger
    [[[Configuration Instance] rac_signalForSelector:@selector(checkout)] subscribeNext:^(id x) {
        @strongify(self);
        self.selectedIndex = 0;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self introduction];
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController
{
    if (viewController == tabBarController.viewControllers[0] ||
        viewController == tabBarController.viewControllers[1] ||
        viewController == tabBarController.viewControllers[2] ||
        viewController == tabBarController.viewControllers[3]
        ) {
        
        if ([self isLogin]) {
            return YES;
        }
        else
            return NO;
    } else {
        return YES;
    }
    return YES;
}


- (IBAction)shareAction
{
    __weak typeof(self) weakSelf = self;
    
    // 创建代表每个按钮的模型
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给朋友"
                                               icon:@"Action_Share"
                                            handler:^{
                                                [BCWXShareProvider shareWebPage:BCWX_SESSION withTitle:@"美育星光" text:@"美育教育在线课堂" image:[UIImage imageNamed:@"icon"] webUrl:SHARE_URL complete:^(BOOL suc, NSString *errMsg) {
                                                    ;
                                                }];
                                            
                                            }];
    
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                               icon:@"Action_Moments"
                                            handler:^{
                                                
                                                [BCWXShareProvider shareWebPage:WXSceneTimeline withTitle:@"美育星光" text:@"美育教育在线课堂" image:[UIImage imageNamed:@"icon"] webUrl:SHARE_URL complete:^(BOOL suc, NSString *errMsg) {
                                                    ;
                                                }];
                                                
                                              
                                            }];
    
//    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
//                                               icon:@"Action_MyFavAdd"
//                                            handler:^{ [weakSelf itemAction:@"点击了收藏"]; }];
//    
//    ZYShareItem *item3 = [ZYShareItem itemWithTitle:@"QQ空间"
//                                               icon:@"Action_qzone"
//                                            handler:^{ [weakSelf itemAction:@"点击了QQ空间"]; }];
    
    ZYShareItem *item4 = [ZYShareItem itemWithTitle:@"QQ"
                                               icon:@"Action_QQ"
                                            handler:^{
                                                
                                                NSData* data = UIImagePNGRepresentation([UIImage imageNamed:@"icon"]);
                                                NSURL* url = [NSURL URLWithString:SHARE_URL];
                                                
                                                /*
                                                 * QQApiVideoObject类型的分享，目前在android和PC上接收消息时，展现有问题，待手Q版本以后更新支持
                                                 * 目前如果要分享视频请使用 QQApiNewsObject 类型，URL填视频所在的H5地址
                                                 
                                                 QQApiVideoObject* img = [QQApiVideoObject objectWithURL:url title:apiObjEditCtrl.objTitle.text description:apiObjEditCtrl.objDesc.text previewImageData:data];
                                                 */
                                                
                                                QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:@"美育星光" description:@"美育教育在线课堂" previewImageData:data];
                                                
                                                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
                                                
                                                QQApiSendResultCode sent = [QQApiInterface sendReq:req];
                                                //[self handleSendResult:sent];
                                                
                                            }];
    
//    ZYShareItem *item5 = [ZYShareItem itemWithTitle:@"Facebook"
//                                               icon:@"Action_facebook"
//                                            handler:^{ [weakSelf itemAction:@"点击了Facebook"]; }];
//    
//    ZYShareItem *item6 = [ZYShareItem itemWithTitle:@"查看公众号"
//                                               icon:@"Action_Verified"
//                                            handler:^{ [weakSelf itemAction:@"点击了查看公众号"]; }];
//    
//    ZYShareItem *item7 = [ZYShareItem itemWithTitle:@"复制链接"
//                                               icon:@"Action_Copy"
//                                            handler:^{ [weakSelf itemAction:@"点击了复制链接"]; }];
//    
//    ZYShareItem *item8 = [ZYShareItem itemWithTitle:@"调整字体"
//                                               icon:@"Action_Font"
//                                            handler:^{ [weakSelf itemAction:@"点击了调整字体"]; }];
//    
//    ZYShareItem *item9 = [ZYShareItem itemWithTitle:@"刷新"
//                                               icon:@"Action_Refresh"
//                                            handler:^{ [weakSelf itemAction:@"点击了刷新"]; }];
    
    NSArray *shareItemsArray = @[item0, item1, item4];
    NSArray *functionItemsArray = nil;
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:shareItemsArray
                                                    functionItems:functionItemsArray];
    // 弹出shareView
    [shareView show];
    
    /*
     // OR
     ZYShareView *shareView = [[ZYShareView alloc] initWithItemsArray:@[shareItemsArray, functionItemsArray]];
     [shareView show];
     */
}

@end
