//
//  CourseCommentViewController.h
//  EDU
//
//  Created by renxingguo on 2016/10/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCommentViewController : UIViewController

@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
