//
//  RegisterViewControllerV2_1.h
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCodeButton.h"
#import "FRHyperLabel.h"

@interface RegisterViewControllerV2_1 : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;       //  手机号
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;       //校码码


@property (weak, nonatomic) IBOutlet VerifyCodeButton *validCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet FRHyperLabel *hyperLabel;

@end
