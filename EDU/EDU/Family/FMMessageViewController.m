//
//  FMMessageViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/26.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMMessageViewController.h"
#import "ReactiveCocoa.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "JSONHTTPClient.h"
#import "Toast.h"
#import "YYText/YYText.h"

@interface FMMessageViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation FMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    {
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"您将向"  ];
        one.yy_font = [UIFont boldSystemFontOfSize:13];
        one.yy_color = [UIColor darkGrayColor];
        [text appendAttributedString:one];
        
        NSMutableAttributedString *phone = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.phone]];
        phone.yy_font = [UIFont boldSystemFontOfSize:13];
        phone.yy_color = [UIColor colorWithRed:17/255.0 green:149/255.0 blue:217/255.0 alpha:1.0];
        [text appendAttributedString:phone];
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"发送如下短信："  ];
            one.yy_font = [UIFont boldSystemFontOfSize:13];
            one.yy_color = [UIColor darkGrayColor];
            [text appendAttributedString:one];
        }
        
        self.headLabel.attributedText = text;
    }
    
    self.messageTextField.text = [NSString stringWithFormat:@"你的%@ %@正在使用<<家谱>>APP制作家谱，邀请您一起完成。请到应用市场搜索\"家谱\"下载安装",
                                  self.callName,self.name
                                  ];
    
    self.sendButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        
        if ([MFMessageComposeViewController canSendText]) {
            
            MFMessageComposeViewController *mCtr = [[MFMessageComposeViewController alloc] init];
            mCtr.messageComposeDelegate = self;
            mCtr.recipients = @[self.phone];
            mCtr.body = self.messageTextField.text;
            [self presentViewController:mCtr animated:YES completion:nil];
        }
        else
        {
            NSLog(@"请开启定位功能！");
            [[[Toast alloc] initWithMessage:@"请开短信功能！"] show];
        }
        return [RACSignal empty];
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MFMessageComposeViewController 代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    //    //0 取消  1是成功 2是失败
    [controller dismissViewControllerAnimated:YES completion:^{
        ;
    }];
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
