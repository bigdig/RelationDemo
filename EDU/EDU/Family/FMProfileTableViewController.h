//
//  FMProfileTableViewController.h
//  EDU
//
//  Created by renxingguo on 2016/12/21.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMProfileTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;

@property (weak, nonatomic) IBOutlet UITextField *sexTextField;

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
