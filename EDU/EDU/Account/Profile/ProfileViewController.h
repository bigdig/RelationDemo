//
//  ProfileViewController.h
//  EDU
//
//  Created by renxingguo on 16/9/9.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "VerifyCodeButton.h"

@interface ProfileViewController : UIViewController
{
}

@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;

@property (retain, nonatomic) IBOutlet UITextField *nicknameTextField;      //昵称
@property (retain, nonatomic) IBOutlet UITextField *schoolTextField;      //学校
@property (retain, nonatomic) IBOutlet UITextField *gradeTextField;       //校码码
@property (retain, nonatomic) IBOutlet UITextField *specialistTextField;       //校码码
@property (retain, nonatomic) IBOutlet UITextField *certification;      //证书

@property (weak, nonatomic) IBOutlet UIButton *saveProfileButton;


@end

