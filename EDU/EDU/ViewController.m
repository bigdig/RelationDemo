//
//  ViewController.m
//  MCStopTableView
//
//  Created by MC on 16/3/30.
//  Copyright © 2016年 MC. All rights reserved.
//
#define KHeaderViewHeight  64
#define KSegmentBarHeight  44

#import "ViewController.h"
#import "MCStopView.h"
#import "MCTableViewController.h"
#import "MCContentCollectionView.h"
#import "UINavigationBar+Background.h"
#import "FirstViewController.h"
#import "UIViewController+Login.h"
@interface ViewController ()
{
    MCTableViewController * TableView2;

    MCContentCollectionView * CollectionView;
    MCTableViewController   * vc_me;
    
    UIViewController *firstVC;
    
    UIImageView *imgview ;
    UILabel *lableView;
    
    MCStopView * stopView;
}

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//导航栏的背景色是黑色, 字体为白色
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    self.navigationController.navigationBar.tintColor = COLOR_RED;
    self.navigationController.navigationBarHidden= YES;
    
    if ([self isLogin]) {
        if(stopView==nil)
        {
            stopView = [[MCStopView alloc]initWithFrame:CGRectMake(0, 0,Main_Screen_Width , Main_Screen_Height) HeaderViewHeight:KHeaderViewHeight SegmentBarHeight:KSegmentBarHeight HeaderView:[self prepareHeaderView] ContentViews:[self prepareContentViews] SegmentsTitles:@[@"",@"",@"",@""] HeaderImg:lableView];
            
            
            [self.view addSubview:stopView];
        }

    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar cnReset];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"";
    
}

-(UIView*)prepareHeaderView1{
    
     UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, KHeaderViewHeight)];
//    headerView.backgroundColor = [UIColor redColor];
   imgview = [[UIImageView alloc]initWithFrame:headerView.bounds];
    imgview.image = [UIImage imageNamed:@"8d82c08430e7780d5c257ddb1b1401b8.jpg"];
    [headerView addSubview:imgview];
    imgview.tag = 100;
    return headerView;
}

//显示一个title
-(UIView*)prepareHeaderView{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, KHeaderViewHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    lableView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, KHeaderViewHeight)];
    lableView.text = @"美育星光";
    lableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    lableView.textColor = COLOR_RED;
    lableView.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:lableView];
    lableView.tag = 100;
    return headerView;
}

-(NSMutableArray*)prepareContentViews{
    NSMutableArray * array = [NSMutableArray
                              array];
    

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    firstVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [array addObject:firstVC.view];
    [self addChildViewController:firstVC];
    
    {
        UICollectionViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseGroupCollectionViewController"];
        [array addObject:vc.collectionView];
        [self addChildViewController:vc];
    }
    
    {
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DownloadTableViewController"];
        [array addObject:vc.view];
        [self addChildViewController:vc];
    }
    
    {
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SetTableViewController"];
        [array addObject:vc.view];
        [self addChildViewController:vc];
    }
    
    
//    CollectionView = [MCContentCollectionView contentCollectionViewFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - KSegmentBarHeight - 64)];
//    [array addObject:CollectionView];
//    
//    
//    
//    TableView2 = [MCTableViewController contentTableViewFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - KSegmentBarHeight - 64)];
//    [array addObject:TableView2];
    
    return array;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
