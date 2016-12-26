//
//  LoginViewController.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/22.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "Toast.h"
#import "UITextField+PaddingText.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

#pragma mark - initialization and memory manage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
         XLOG(@"==========登录==========");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.phoneNumTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    if ([[Configuration Instance] phoneNumber]) {
        self.phoneNumTextField.text = [[Configuration Instance] phoneNumber];
    }
    
    self.loginViewModel = [[LoginViewModel alloc] init];
    [self bindModel];
    
    [self.loginViewModel.LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;

        if ([success boolValue]) {
            //login success
            [self BackBtn:nil];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
        }
    }];
    
    
    //custom view
    {
        self.phoneNumTextField.layer.cornerRadius = 22.5;
        self.phoneNumTextField.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
        self.phoneNumTextField.layer.borderWidth = 1;
        self.phoneNumTextField.layer.masksToBounds = YES;
        
        [self.phoneNumTextField setLeftPadding:20];
    }
    {
        self.passwordTextField.layer.cornerRadius = 22.5;
        self.passwordTextField.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
        self.passwordTextField.layer.borderWidth = 1;
        self.passwordTextField.layer.masksToBounds = YES;
        
        [self.passwordTextField setLeftPadding:20];
    }
    
    //forget password
    [Configuration Instance].resetPassword = FALSE;
    UIButton *btn = [self.view viewWithTag:100];
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [Configuration Instance].resetPassword = TRUE;
        return [RACSignal empty];
    }];
}

// 视图模型绑定
- (void)bindModel
{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel, account) = _phoneNumTextField.rac_textSignal;
    RAC(self.loginViewModel, password) = _passwordTextField.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginButton,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // 执行登录事件
        [self.passwordTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.loginViewModel.LoginCommand execute:nil];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.phoneNumTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passwordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

//返回
- (IBAction)BackBtn:(id)sender {
    if ([self.navigationController.viewControllers count]>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }
}

#pragma mark Actions

#pragma mark
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }

    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollview adjustOffsetToIdealIfNeeded];
}

@end
