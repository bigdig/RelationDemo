//
//  ResigeViewController.h
//  DressingCollection
//
//  Created by fan junChao on 13-5-2.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "VerifyCodeButton.h"

@interface ResigeViewController : UIViewController
{
}

@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;

@property (retain, nonatomic) IBOutlet UITextField *phoneNumTextField;       //  手机号
@property (retain, nonatomic) IBOutlet UITextField *nicknameTextField;      //昵称
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;      //密码
//@property (retain, nonatomic) IBOutlet UITextField *secondPasswordTextField;       //新密码
@property (retain, nonatomic) IBOutlet UITextField *verifyCodeTextField;       //校码码
@property (retain, nonatomic) IBOutlet UITextField *invitationTextField;       //校码码


@property (retain, nonatomic) IBOutlet VerifyCodeButton *validCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registeButton;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@end
