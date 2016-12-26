//
//  EditPasswordViewController.h
//  DressingCollection
//
//  Created by fan junChao on 13-5-15.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "VerifyCodeButton.h"

@interface EditPasswordViewController : UIViewController
{
}

- (IBAction)changePassword:(id)sender;

@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;

@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;       //手机号
@property (retain, nonatomic) IBOutlet UITextField *firtPasswordTextField;       //新密码
@property (retain, nonatomic) IBOutlet UITextField *verifyCodeTextField;       //验证码

@property (retain, nonatomic) IBOutlet VerifyCodeButton *validCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitButton; //提交按钮

@end
