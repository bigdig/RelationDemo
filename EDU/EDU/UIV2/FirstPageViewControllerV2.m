//
//  FirstPageViewControllerV2.m
//  EDU
//
//  Created by renxingguo on 2016/10/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FirstPageViewControllerV2.h"
#import "UIViewController+SimulateContainer.h"
#import "UIViewController+Login.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "SearchResultViewController.h"

#import "DramaClubListViewController.h"
#import "UISearchBar+FMAdd.h"
#import "FirstPageGroupCourseViewController.h"

#import "UIButton+Expand.h"
#import "WEPopoverController.h"

@interface FirstPageViewControllerV2 ()

@property (strong,nonatomic) UIViewController *vc0;
@property (strong,nonatomic) UIViewController *vc1;
@property (strong,nonatomic) UIViewController *vc2;
@property (strong,nonatomic) DramaClubListViewController *vc3;
@property (strong,nonatomic) UIViewController *vc4;

@property (strong,nonatomic) WEPopoverController *wePopoverController;

@end

@implementation FirstPageViewControllerV2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 添加到self.navigationItem.titleView中
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    // 添加到self.view中
    [self.view addSubview:self.tableView];
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self.tableView reloadData];
        return [RACSignal empty];
    }];

    self.vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"AdvertismentViewController"];
    self.vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"WonderfulArticlesViewController"];
    self.vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"WorksListViewController"];
    self.vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"DramaClubListViewController"];
    self.vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstPageGroupCourseViewController"];
    
    self.vc3.maxShowCount = 6;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    if ([self isLogin]) {
        ;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *identifier = @"cell_0";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            UIView *ad = [cell viewWithTag:100];
            [self bindConstainerTo:self.vc0 withView:ad];
            //[self bindConstainer:@"AdvertismentViewController" withView:ad];
            
            {
                @weakify(self);
                UIButton *moreButton = [cell viewWithTag:101];
                [moreButton setEnlargeEdge:10]; 

                moreButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    @strongify(self);
                    if (self.wePopoverController) {
                        [self.wePopoverController dismissPopoverAnimated:YES];
                        self.wePopoverController = nil;
                    } else {
                        UIViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QuationHint1"];  // this is the storyboard id
                        
                        self.wePopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
                        
                        CGRect rect = moreButton.frame;
                        [self.wePopoverController presentPopoverFromRect:rect
                                                                  inView:moreButton.superview
                                                permittedArrowDirections:UIPopoverArrowDirectionUp
                                                                animated:YES];
                    }
                    return  [RACSignal empty];
                }];
                
                {
                    UIView *v = [self.view viewWithTag:1000];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
                    [v addGestureRecognizer:tap];
                    [[tap rac_gestureSignal] subscribeNext:^(id x) {
                        [moreButton.rac_command execute:nil];
                    }];
                }
            }
            
            {
                UIButton *btn1 = [cell viewWithTag:110];
                btn1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    [Configuration Instance].current_group_id = 23;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListCollectionViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    return  [RACSignal empty];
                }];
            }
            
            {
                UIButton *btn1 = [cell viewWithTag:120];
                btn1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    [Configuration Instance].current_group_id = 24;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListCollectionViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    return  [RACSignal empty];
                }];
            }
            
            {
                UIButton *btn1 = [cell viewWithTag:130];
                btn1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    [Configuration Instance].current_group_id = 25;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListCollectionViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    return  [RACSignal empty];
                }];
            }
            
            /**
            {
                UIButton *btn1 = [cell viewWithTag:140];
                btn1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    [Configuration Instance].current_group_id = 22;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListCollectionViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    return  [RACSignal empty];
                }];
            }
             */
            return cell;
        }
            break;
        case 4:
        {
            static NSString *identifier = @"cell_4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            UIView *ad = [cell viewWithTag:100];
            CGRect rect = ad.frame;
            rect.size.height = 190.0;
            ad.frame = rect;
            [self bindConstainerTo:self.vc1 withView:ad];
            //[self bindConstainer:@"WonderfulArticlesViewController" withView:ad];
            return cell;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"cell_2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            UIView *ad = [cell viewWithTag:100];
            [self bindConstainerTo:self.vc2 withView:ad];
            //[self bindConstainer:@"WorksListViewController" withView:ad];
            return cell;
        }
            break;
        case 3:
        {
            static NSString *identifier = @"cell_3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            UIView *ad = [cell viewWithTag:100];
            [self bindConstainerTo:self.vc3 withView:ad];
            //[self bindConstainer:@"WorksListViewController" withView:ad];
            return cell;
        }
        case 1:
        {
            static NSString *identifier = @"cell_1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            UIView *ad = [cell viewWithTag:100];
            [self bindConstainerTo:self.vc4 withView:ad];
            return cell;
        }
            break;
        case 5:
        {
            static NSString *identifier = @"cell_5";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 270.0;
            break;
        case 4:
            return 190.0;
            break;
        case 2:
            return 170;
            break;
        case 3:
            return Main_Screen_Width*210*2/240/3 + 40;
            break;
        case 1:
            return 165.0;
            break;
        case 5:
            return 20;
            break;
        default:
            break;
    }
    return 0.0;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
