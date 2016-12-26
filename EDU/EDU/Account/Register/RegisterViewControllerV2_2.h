//
//  RegisterViewControllerV2_2.h
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRHyperLabel.h"

@interface RegisterViewControllerV2_2 : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;       //年级
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;      //学校
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;       //年级

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet FRHyperLabel *hyperLabel;
@end
