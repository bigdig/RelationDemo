//
//  FirstPageViewControllerV2.h
//  EDU
//
//  Created by renxingguo on 2016/10/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  UITableViewDelegate, UITableViewDataSource              ——UITableView代理
 *  UISearchControllerDelegate, UISearchResultsUpdating     ——UISearchController代理
 */
@interface FirstPageViewControllerV2 : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@end
