//
//  PureSearchViewController.m
//  EDU
//
//  Created by renxingguo on 2016/11/11.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "PureSearchViewController.h"
#import "SearchResultViewController.h"

#import "DramaClubListViewController.h"
#import "UISearchBar+FMAdd.h"

@interface PureSearchViewController ()

@end

@implementation PureSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 添加到self.navigationItem.titleView中
    //center it
    self.navigationItem.titleView = self.searchController.searchBar;
    [[self.navigationItem.titleView rac_signalForSelector:@selector(setFrame:)] subscribeNext:^(id x) {
        UIView *s = self.searchController.searchBar;
        s.center = CGPointMake(s.superview.center.x, s.center.y);
    }];
    self.definesPresentationContext = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchController UISearchControllerDelegate
// These methods are called when automatic presentation or dismissal occurs. They will not be called if you present or dismiss the search controller yourself.
- (void)willPresentSearchController:(UISearchController *)searchController {
    
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    
}
- (void)willDismissSearchController:(UISearchController *)searchController {
    
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    
}

// Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
- (void)presentSearchController:(UISearchController *)searchController {
    
}

#pragma mark - 实例化

- (UISearchController *)searchController {
    if (!_searchController) {
        
        SearchResultViewController *resultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
        
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
        
        //set search bar
        resultsController.searchBar = searchController.searchBar;
        resultsController.parent = self;
        
        searchController.delegate = self;
        //searchController.searchResultsUpdater = resultsController;
        [searchController.searchBar sizeToFit];
        searchController.dimsBackgroundDuringPresentation = YES;        //是否添加半透明覆盖层
        searchController.hidesNavigationBarDuringPresentation = NO;    //是否隐藏导航栏
        
        // 这里还可以自定义searchController.searchBar。UISearchBar的属性都可以设置
        searchController.searchBar.placeholder = @"课程、视频、戏剧社、专题";
        
        //设置背景图是为了去掉上下黑线
        
        //1. 设置背景颜色
        //设置背景图是为了去掉上下黑线
        searchController.searchBar.backgroundImage = [[UIImage alloc] init];
        // 设置SearchBar的颜色主题为白色
        searchController.searchBar.barTintColor = [UIColor whiteColor];
        
        //2. 设置圆角和边框颜色
        UITextField *searchField = [searchController.searchBar valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBackgroundColor:[UIColor whiteColor]];
            searchField.layer.cornerRadius = 14.0f;
            searchField.layer.borderColor = COLOR_LITLE_GREE.CGColor;
            searchField.layer.borderWidth = 1;
            searchField.layer.masksToBounds = YES;
        }
        
        //3. 设置按钮文字和颜色
        [searchController.searchBar fm_setCancelButtonTitle:@"取消"];
        searchController.searchBar.tintColor = COLOR_LITLE_GREE;
        //设置取消按钮字体
        [searchController.searchBar fm_setCancelButtonFont:[UIFont systemFontOfSize:18]];
        //修正光标颜色
        [searchField setTintColor:[UIColor blackColor]];
        
        //4. 设置输入框文字颜色和字体
        [searchController.searchBar fm_setTextColor:[UIColor blackColor]];
        [searchController.searchBar fm_setTextFont:[UIFont systemFontOfSize:14]];
        
        _searchController = searchController;
    }
    return _searchController;
}

@end
