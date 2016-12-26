//
//  CourseDetailTableViewControllerV2.h
//  EDU
//
//  Created by renxingguo on 2016/12/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailTableViewControllerV2 : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIView *floatView;

@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@end
