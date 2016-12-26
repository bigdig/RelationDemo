//
//  SchoolSelectViewControllerV2.h
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolSelectViewControllerV2 : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveWidthConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
