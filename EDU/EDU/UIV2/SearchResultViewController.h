//
//  SearchResultViewController.h
//  EDU
//
//  Created by renxingguo on 2016/10/13.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController

@property (weak, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) UIViewController *parent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
