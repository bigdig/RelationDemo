//
//  LoginViewController.h
//  DressingCollection
//
//  Created by fan junChao on 13-5-2.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;  //填写电话
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;  //密码
@property (weak, nonatomic) IBOutlet UIButton *loginButton; //login button

@end
