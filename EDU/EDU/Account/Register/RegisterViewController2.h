//
//  RegisterViewController2.h
//  EDU
//
//  Created by renxingguo on 2016/10/17.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCodeButton.h"

@interface RegisterViewController2 : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet VerifyCodeButton *verifyCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *button;

@end
