//
//  WXLoginViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "WXLoginViewController.h"
#import "ReactiveCocoa.h"

@interface WXLoginViewController ()

@end

@implementation WXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    self.wxButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        SendAuthReq *req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo"; // 此处不能随意改
        req.state = @"123"; // 这个貌似没影响
        [WXApi sendReq:req];
        return [RACSignal empty];
    }];
    
    
    self.mobileButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //animation
            
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRegisterViewController"];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:ctl];
            [self presentViewController:nav animated:YES completion:^{
                ;
            }];
            return nil;
        }] deliverOnMainThread];
    }];
    

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

@end
