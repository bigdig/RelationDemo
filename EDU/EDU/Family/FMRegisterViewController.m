//
//  FMRegisterViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/20.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMRegisterViewController.h"
#import "BloomFilter.h"
#import "NSString+MD5.h"
#import "ReactiveCocoa.h"
#import "Toast.h"
#import "UITextField+PaddingText.h"
#import "FRHyperLabel.h"


@interface FMWtFaUserLoginModel : JSONModel
/**
 {"code":1,"message":"success","info":{"user_id":88763,"user_name":"袁东华","mobile_phone":"18801123830","avatar":"/data/avatar/2015/09/02/14/88763/.png","recode":"4","redesc":"成功!"}
 */
@property (nonatomic,strong) NSString<Optional> *user_id;
@property (nonatomic,strong) NSString<Optional> *name;
@property (nonatomic,strong) NSString<Optional> *mobile;
@property (nonatomic,strong) NSString<Optional> *avatar;
@property (nonatomic,strong) NSString<Optional> *pwd;
@property (nonatomic,strong) NSString<Optional> *sex;
@property (nonatomic,strong) NSString<Optional> *wxid;
@property (nonatomic,strong) NSString<Optional> *wxnick;
@property (nonatomic,strong) NSString<Optional> *wxpic;

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation FMWtFaUserLoginModel

/**
 1：微信用户不存在，请绑定手机注册；
 0：登录成功;
 */
- (BOOL)isSuccess
{
    return self.code == 1;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"code": @"code",
                                                       @"message":@"message",
                                                       @"info.faUser.id":@"user_id",
                                                       @"info.faUser.name":@"name",
                                                       @"info.faUser.mobile":@"mobile",
                                                       @"info.faUser.pic":@"avatar",
                                                       @"info.faUser.pwd":@"pwd",
                                                       @"info.faUser.sex":@"sex",
                                                       @"info.faUser.wxid":@"wxid",
                                                       @"info.faUser.wxnick":@"wxnick",
                                                       @"info.faUser.wxpic":@"wxpic",
                                                       
                                                       }];
}

@end


@interface FMRegisterViewController ()

@property (nonatomic,strong) RACCommand *registerCommand;

@end

@implementation FMRegisterViewController


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
            [self.validCodeBtn requestVerifyCode:self.phoneNumTextField.text];
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
        [[_registerCommand execute:nil] subscribeNext:^(RACTuple *x) {
            if ([x.first boolValue]) {
                if ([[Configuration Instance].userName length] == 0 ||
                    [[Configuration Instance].userName compare:@"家谱用户"] == NSOrderedSame
                    ) {
                    //complte profile
                    UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMProfileTableViewController"];
                    [self.navigationController pushViewController:ctl animated:YES];
                }
                else
                {
                    //show ralation
                    UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRelationViewController"];
                    [self.navigationController pushViewController:ctl animated:YES];
                }
            }
        }];
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
    /**
    {
        [self.hyperLabel setLinkForSubstring:@"美育星光服务条款" withLinkHandler:^(FRHyperLabel *label, NSString *substring){
            //            [[UIApplication sharedApplication] openURL:aURL];
            UIViewController * vc = [[QQPlayViewController alloc] init];
            [Configuration Instance].current_video_url_title = @"服务条款";
            [Configuration Instance].current_video_url = @"http://dt.xingguangedu.com/clause/clause.html";
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
     */
    
    // 处理登录业务逻辑
    _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {

                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    NSString *devicetoken = [userDefaults objectForKey:@"DeviceTokenStringKEY"];
                    
                    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                    
                    NSString *password = @"1234567";
                    NSDictionary* para= @{@"device_code":devicetoken,
                                          @"device_name":[[UIDevice currentDevice] model],
                                          @"mobile":self.phoneNumTextField.text,
                                          @"pwd": [password MD5Hash],
                                          @"appver": [NSString stringWithFormat:@"I_%@",version],
                                          @"channel":@"IOS"
                                          };
                    
                    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/wtFaUserLogin.json",BASEURL]
                                                       params:para
                                                   completion:^(id json, JSONModelError *err) {
                                                       
                                                       //check err, process json ...
                                                       FMWtFaUserLoginModel *model = [[FMWtFaUserLoginModel alloc] initWithDictionary:json error:nil];
                                                       
                                                       if (!model.isSuccess)
                                                       {
                                                           [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                       }
                                                       else
                                                       {
                                                           [[NSUserDefaults standardUserDefaults]setValue:model.user_id forKey:@"user_id" ];
                                                           [[NSUserDefaults standardUserDefaults]synchronize];
                                                           
                                                           [[Configuration Instance]saveUserID:model.user_id  andUserName:model.name andUserRank:Nil andRankName:Nil andRankImg:Nil andPhone:model.mobile];
                                                           [[Configuration Instance] setPassword: [para valueForKey:@"password"]];
                                                           [[Configuration Instance] setAvatar: [[NSString stringWithFormat:@"%@/%@",Prefix,model.avatar] URLEncodedStringFix]];
                                                           
                                                           [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                                           
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
                                                           
                                                       }
                                                       [subscriber sendCompleted];
                                                   }];
                    
                    return nil;
                }];
    }];

}

@end
