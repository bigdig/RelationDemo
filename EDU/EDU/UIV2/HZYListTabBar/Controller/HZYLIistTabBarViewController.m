//
//  HZYLIistTabBarViewController.m
//  HZYListTabBarDemo
//
//  Created by MS on 16-3-11.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYLIistTabBarViewController.h"
#import "HZYListTabBar.h"
#import "JSONHTTPClient.h"
#import "EDUArticlesClsListDataModels.h"

#import "ArticlesListViewController.h"

#define HZYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0]

//屏幕的SIZE
#define kScreenSize [UIScreen mainScreen].bounds.size

//箭头按钮的宽度
#define kArrowButtonW 40.0

//listTabBar 的高度
#define kListTabBarH  kArrowButtonW

//导航栏的Y
#define kNavY 64.0



//listtabBarItem的间距
#define kItemsPadding 30.0

#define klistTabBarBundleName           @"HZYResource.bundle"

#define klistTabBarResourcesPath(file) [klistTabBarBundleName stringByAppendingPathComponent:file]



@interface HZYLIistTabBarViewController ()<HZYListTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) HZYListTabBar *listTabBar;
/**
 *  装有ViewController的ScrollView
 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
/**
 *  当前viewController的索引
 */
@property (nonatomic, assign)NSInteger currentIndex;

@property (nonatomic,strong) EDUArticlesClsListBaseClass * logReason;
@property (nonatomic,strong) NSArray *titles;

@end

@implementation HZYLIistTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"精彩专题";
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, logReason)] reduce:^id{
        @strongify(self);
        return @(self.logReason!=nil);
    }] subscribeNext:^(id x) {
        if ([x boolValue]) {
            //
            @strongify(self);
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            //add 全部
            {
                ArticlesListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesListViewController"];
                vc.cls_id= @"";
                [self addChildViewController:vc];
                [titles addObject:@"全部"];
            }
            
            [self.logReason.info enumerateObjectsUsingBlock:^(EDUArticlesClsListInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ArticlesListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesListViewController"];
                vc.cls_id = [[NSNumber numberWithDouble:obj.infoIdentifier] stringValue];
                [self addChildViewController:vc];
                
                [titles addObject:obj.name];
            }];
            
            self.titles = titles;
            [self initView];
        }
    }];
    
    //取条目信息
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/shaArticlesClsList.json",BASEURL] params:nil completion:^(id json, JSONModelError *err) {
        //
        EDUArticlesClsListBaseClass *model = [[EDUArticlesClsListBaseClass alloc] initWithDictionary:json];
        self.logReason = model;
    }];
    
}

/**
 *  初始化试图控制器
 */
- (void)initView{

    //设置控制器是否自动调整他内部scrollView内边距（一定要设置为NO,否则在导航条显示的时候,scroolView的第一个控制器显示的tableView会有偏差）
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置能够滑动的listTabBar
    self.listTabBar = [[HZYListTabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kListTabBarH)];
    self.listTabBar.delegate = self;
    //这句代码调用了HZYListTabBar的 setitemsTitle 方法  会到HZYListTabBar里设置数据
    self.listTabBar.itemsTitle = self.titles;
    [self.view addSubview:self.listTabBar];
    
    //添加能滚动显示ViewController的ScrollView
    CGFloat scroolY = CGRectGetMaxY(self.listTabBar.frame);
    CGFloat scroolH = kScreenSize.height - scroolY - 64;
    
    UIScrollView *contentScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroolY, kScreenSize.width, scroolH)];

    contentScroolView.showsHorizontalScrollIndicator = NO;
    contentScroolView.delegate = self;
    
    //设置scrollView能够分页
    contentScroolView.pagingEnabled = YES;
    //关闭scrollView的弹簧效果
    contentScroolView.bounces = NO;
    contentScroolView.backgroundColor = [UIColor whiteColor];
    
    self.contentScrollView = contentScroolView;
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.contentSize = CGSizeMake(kScreenSize.width * self.childViewControllers.count,0);
    
    //添加默认显示的控制器
    UIViewController *newsVc = [self.childViewControllers firstObject];
    newsVc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:newsVc.view];
    
    //goto page index
    @weakify(self);
    [self.logReason.info enumerateObjectsUsingBlock:^(EDUArticlesClsListInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.infoIdentifier == self.scrollToIndex) {
            self.listTabBar.currentItemIndex = idx;
            [self.contentScrollView setContentOffset:CGPointMake(idx * kScreenSize.width, 0) animated:YES];
        }
    }];

}

#pragma mark -- scrollView 的代理方法 --

/**
 *  scrollView 滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //当scrollView滑动超过了屏幕一半时就让它进入下一个界面
    self.currentIndex = scrollView.contentOffset.x / kScreenSize.width + 0.5;
   
}

/**
 *  scrollView 动画滚动结束时调用  只有通过代码（设置contentOfset）使scrollView停止滚动才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    //这句代码调用了HZYListTabBar的 setCurrentItemIndex 方法  会到HZYListTabBar里设置数据
    self.listTabBar.currentItemIndex = self.currentIndex;
    
    UIViewController *vc = self.childViewControllers[self.currentIndex];
    //如果当前试图控制器的View已经加载过了,就直接返回,不会重新加载了（这句代码很重要）
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = scrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
}

/**
 *  这个是由手势导致scrollView滚动结束调用（减速）(不实现这个代理方法用手滑scrollView并不会加载控制器)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -- HZYListTabBar的代理方法 --
- (void)listTabBar:(HZYListTabBar *)listTabBar didSelectedItemIndex:(NSInteger)index{
    
    [self.contentScrollView setContentOffset:CGPointMake(index * kScreenSize.width, 0) animated:YES];
}

- (void)listTabBarDidClickedArrowButton:(HZYListTabBar *)listTabBar{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"抱歉,显示当前关注的item和添加更多item暂时还没有实现,等有时间了再去跟新！" delegate:nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
