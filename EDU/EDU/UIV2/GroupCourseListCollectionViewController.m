//
//  GroupCourseListCollectionViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/14.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "GroupCourseListCollectionViewController.h"
#import "UICollectionView+Empty.h"
#import "EDUGroupCourseListDataModels.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Scroll.h"
#import "JSONHttpClient.h"
#import "PFNavigationDropdownMenu.h"
#import "UIViewController+SimulateContainer.h"
#import "HZYListTabBar.h"
#import "EDUTagListDataModels.h"

@interface GroupCourseListCollectionViewController ()<HZYListTabBarDelegate>

@property (nonatomic,strong) EDUGroupCourseListBaseClass* model;
@property (nonatomic,strong) HZYListTabBar *listTabBar;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSString *tagID;
@property (nonatomic,strong) NSMutableDictionary *tileTagDic;

@property (nonatomic,strong) UIButton *moreButton;
@end

@implementation GroupCourseListCollectionViewController

static NSString * const reuseIdentifier = @"group_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"";
    //显示全部
    [Configuration Instance].tagName = @"全部";
    
    self.collectionView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //
        
        NSMutableDictionary* para = [[NSMutableDictionary alloc] init];
        [para setObject:[[NSNumber numberWithDouble:[Configuration Instance].current_group_id] stringValue] forKey:@"group_id"];
        if (self.tagID && [self.tagID length] && [self.tagID compare:@"0"] != NSOrderedSame) {
            [para setObject:self.tagID forKey:@"tag_id"];
        }
        
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resGroupCourseList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [[EDUGroupCourseListBaseClass alloc] initWithDictionary:json];
//            self.navigationItem.title = self.model.info.group.longTitle;
            //self.navigationItem.title =  [NSString stringWithFormat:@" %@ ", self.model.info.group.longTitle ];
            
            [self.collectionView reloadData];
        }];
        return [RACSignal empty];
    }];
    
    
    //set select lable
    NSArray *items = @[@"1-3年级课堂游戏", @"4-6年级课堂游戏", @"初中课堂游戏"];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:220/255.0 alpha:1.0];
//    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    
    NSUInteger index = 0;
    if ([Configuration Instance].current_group_id == 23) {
        index = 0;
    }
    if ([Configuration Instance].current_group_id == 24) {
        index = 1;
    }
    if ([Configuration Instance].current_group_id == 25) {
        index = 2;
    }
    
    PFNavigationDropdownMenu *menuView = [[PFNavigationDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 150, 44)
                                                                                   title:items[index]
                                                                                   items:items
                                                                           containerView:self.view];
    
    menuView.cellHeight = 50;
    menuView.cellBackgroundColor = [UIColor whiteColor];
    menuView.cellSelectionColor = [UIColor whiteColor];
    menuView.cellTextLabelColor = [UIColor lightGrayColor];
    menuView.cellTextLabelFont = [UIFont fontWithName:@"Avenir-Heavy" size:15];
    menuView.arrowPadding = 15;
    menuView.animationDuration = 0.5f;
    menuView.maskBackgroundColor = [UIColor blackColor];
    menuView.maskBackgroundOpacity = 0.3f;
    menuView.didSelectItemAtIndexHandler = ^(NSUInteger indexPath){
        NSLog(@"Did select item at index: %ld", indexPath);
        switch (indexPath) {
            case 0:
                [Configuration Instance].current_group_id = 23;
                break;
            case 1:
                [Configuration Instance].current_group_id = 24;
                break;
            case 2:
                [Configuration Instance].current_group_id = 25;
                break;
            default:
                break;
        }
        
        [self.collectionView.refreshCommand execute:nil];
    };
    self.navigationItem.titleView = menuView;


    //取条目信息
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resTagList.json",BASEURL] params:nil completion:^(id json, JSONModelError *err) {
        //
        EDUTagListBaseClass *model = [EDUTagListBaseClass modelObjectWithDictionary:json];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:@"全部"];
        
        self.tileTagDic = [[NSMutableDictionary alloc] init];
        [self.tileTagDic setObject:@"0" forKey:@"全部"];
        [model.info.myProperty1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[obj name]];
            NSString *identi =  [[NSNumber numberWithDouble:[obj internalBaseClass1Identifier]] stringValue];
            
            [self.tileTagDic setObject:identi forKey:[obj name]];
        }];
        [model.info.myProperty2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[obj name]];
            NSString *identi =  [[NSNumber numberWithDouble:[obj internalBaseClass2Identifier]] stringValue];
            
            [self.tileTagDic setObject:identi forKey:[obj name]];
        }];
        self.titles = array;
        
        //设置控制器是否自动调整他内部scrollView内边距（一定要设置为NO,否则在导航条显示的时候,scroolView的第一个控制器显示的tableView会有偏差）
        self.automaticallyAdjustsScrollViewInsets = NO;
        //设置能够滑动的listTabBar
        const int barH = 40;
        self.listTabBar = [[HZYListTabBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-40, barH)];
        self.listTabBar.delegate = self;
        //这句代码调用了HZYListTabBar的 setitemsTitle 方法  会到HZYListTabBar里设置数据
        self.listTabBar.itemsTitle = self.titles;
        //[self.view addSubview:self.listTabBar];
        
        UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 0, 40, barH);
        [arrowButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        arrowButton.backgroundColor = [UIColor whiteColor];
        
        [RACObserve([Configuration Instance], tagName) subscribeNext:^(id x) {
            
            [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj compare:[Configuration Instance].tagName] == NSOrderedSame) {
                    self.listTabBar.currentItemIndex = idx;
                }
            }];
            
            self.tagID = [Configuration Instance].tagID;
            [self.collectionView.refreshCommand execute:nil];
            
        }];
        
        arrowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
            UIViewController *tagVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"AHViewController"];
    
            
            [self.navigationController pushViewController:tagVC animated:YES];
            return [RACSignal empty];
        }];
        self.moreButton = arrowButton;
        //[self.view addSubview:arrowButton];

    }];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.model.info.courseList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    EDUGroupCourseListCourseList *item = [self.model.info.courseList objectAtIndex:indexPath.row];
    
    {
        UIImageView *image = [cell viewWithTag:100];
        
        [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
        
        UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:myTapGesture];
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.title;
    }
    
    {
        UILabel *text = [cell viewWithTag:121];
        if ([item.resTags count]) {
            text.hidden = FALSE;
            text.text = [[item.resTags objectAtIndex:0] name];
        }
        else
        {
            text.hidden = TRUE;
            text.text = @"";
        }
    }
    
    {
        UILabel *text = [cell viewWithTag:122];
        if ([item.resTags count]>1) {
            text.hidden = FALSE;
            text.text = [[item.resTags objectAtIndex:1] name];
        }
        else
        {
            text.hidden = TRUE;
            text.text = @"";
        }
    }
    
    
    {
        UILabel *text = [cell viewWithTag:130];
        text.text = item.timeShow;
    }
    
    [cell layoutIfNeeded];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

//- (CGSize)collectionViewContentSize
//{
//    float unit = [UIScreen mainScreen].bounds.size.width;
//    return CGSizeMake(unit, unit);
//}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float unit = ([UIScreen mainScreen].bounds.size.width-4)/2;
    
    return CGSizeMake(unit, unit*258/375);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(void)imageViewClicked:(UITapGestureRecognizer*)gestRecognizer
{
    UIImageView* iv = (UIImageView*)gestRecognizer.view;
    NSInteger tag = iv.tag; // then do what you want with this
    
    // or get the cell by going up thru the superviews until you find it
    UIView* cellView = iv;
    while(cellView && ![cellView isKindOfClass:[UICollectionViewCell class]])
        cellView = cellView.superview; // go up until you find a cell
    
    // Then get its indexPath
    UICollectionViewCell* cell = (UICollectionViewCell*)cellView;
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    EDUGroupCourseListCourseList *item = [self.model.info.courseList objectAtIndex:indexPath.row];
    
    [Configuration Instance].current_course_id = item.courseListIdentifier;
    [Configuration Instance].current_video_url_title = item.title;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
    
//    self.navigationController.navigationBarHidden = FALSE;
    self.navigationItem.title = @"";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.collectionView.scrollDelegate scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.collectionView.scrollDelegate scrollViewDidEndDecelerating:scrollView];
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        //[self bindConstainerTo:_tagVC withView:headerView];
        [headerView addSubview:self.listTabBar];
        [headerView addSubview:self.moreButton];
        
        reusableview = headerView;
    }

    reusableview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    return reusableview;
}

#pragma mark -- HZYListTabBar的代理方法 --
- (void)listTabBar:(HZYListTabBar *)listTabBar didSelectedItemIndex:(NSInteger)index{
    NSString *title = [self.titles objectAtIndex:index];
    self.tagID = [self.tileTagDic objectForKey:title];
    [self.collectionView.refreshCommand execute:nil];
}

@end
