//
//  RegisterViewControllerV2_1.m
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RegisterViewControllerV2_1.h"
#import "BloomFilter.h"
#import "NSString+MD5.h"
#import "ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "Toast.h"
#import "UITextField+PaddingText.h"
#import "FRHyperLabel.h"
#import "QQPlayViewController.h"

@interface RegisterViewControllerV2_1 ()

@end

@implementation RegisterViewControllerV2_1


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.phoneNumTextField becomeFirstResponder];
    self.verifyCodeTextField.enabled = TRUE;
    self.nextButton.enabled = FALSE;
    
    {
        self.validCodeBtn.enabled = FALSE;
        RACSignal *enabled = [RACSignal combineLatest:@[self.phoneNumTextField.rac_textSignal] reduce:^(NSString *text){
            return @(text &&[text length]==11 && [NSString isMobileNumber:text]);
        }];
        
        
        self.validCodeBtn.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
            
            [self.phoneNumTextField resignFirstResponder];
            [self.verifyCodeTextField resignFirstResponder];
            //check user
            //sacUserCheck.json
            NSDictionary* para= @{ @"mobile": self.phoneNumTextField.text
                                   };
            
            [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/sacUserCheck.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                //
                if ([Configuration Instance].resetPassword) {
                    if ( [[[json objectForKey:@"info"] objectForKey:@"recode"] integerValue] == 1) {
                        [self.validCodeBtn requestVerifyCode:self.phoneNumTextField.text];
                        
                    }
                    else
                    {
                        [[[Toast alloc] initWithMessage:@"用户没有注册！"] show];
                    }
                }
                else
                {
                    if ( [[[json objectForKey:@"info"] objectForKey:@"recode"] integerValue] == 1) {
                        [[[Toast alloc] initWithMessage:@"用户已经注册！"] show];
                    }
                    else
                    {
                        [self.validCodeBtn requestVerifyCode:self.phoneNumTextField.text];
                    }
                }
  
            }];
            
            return [RACSignal empty];
        }];
    }
    
    //长度限制
    [self.phoneNumTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PHONENUM_LEN) {
            self.phoneNumTextField.text = [x substringToIndex:MAX_PHONENUM_LEN];
        }
    }];
    

    [self.verifyCodeTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>4) {
            self.verifyCodeTextField.text = [x substringToIndex:4];
        }
        if ([[BloomFilter Instance] lookup:self.verifyCodeTextField.text ]) {
            //self.verifyCodeTextField.textColor = [UIColor greenColor];
            self.nextButton.enabled = TRUE;
        }
        else
        {
            self.verifyCodeTextField.textColor = [UIColor blackColor];
            self.nextButton.enabled = FALSE;
        }
    }];
    
    RACSignal *enableNext = [RACSignal combineLatest:@[self.verifyCodeTextField.rac_textSignal] reduce:^(NSString* x){
        return @([[BloomFilter Instance] lookup:x]);
    }];
    
    self.nextButton.rac_command = [[RACCommand alloc] initWithEnabled:enableNext signalBlock:^RACSignal *(id input) {
        [Configuration Instance].phoneNumber = self.phoneNumTextField.text;
        [Configuration Instance].verifyCode = self.verifyCodeTextField.text;
        return [RACSignal empty];
    }];
    
    {
        //self.phoneNumTextField.layer.cornerRadius = 22.5;
        self.phoneNumTextField.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
        self.phoneNumTextField.layer.borderWidth = 1;
        self.phoneNumTextField.layer.masksToBounds = YES;
        
        [self.phoneNumTextField setLeftPadding:20];
    }
    
    {
        [self.verifyCodeTextField setLeftPadding:20];
    }
    
    UIView *bdview = [self.view viewWithTag:200];
    [bdview setBackgroundColor:[UIColor whiteColor]];
    //bdview.layer.cornerRadius = 14.0f;
    bdview.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    bdview.layer.borderWidth = 1;
    bdview.layer.masksToBounds = YES;
    
    
    //link label
    {
        [self.hyperLabel setLinkForSubstring:@"美育星光服务条款" withLinkHandler:^(FRHyperLabel *label, NSString *substring){
//            [[UIApplication sharedApplication] openURL:aURL];
            UIViewController * vc = [[QQPlayViewController alloc] init];
            [Configuration Instance].current_video_url_title = @"服务条款";
            [Configuration Instance].current_video_url = @"http://dt.xingguangedu.com/clause/clause.html";
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
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
