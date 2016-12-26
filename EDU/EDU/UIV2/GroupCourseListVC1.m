//
//  GroupCourseListVC1.m
//  EDU
//
//  Created by renxingguo on 2016/12/7.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "GroupCourseListVC1.h"

#import "GroupCourseListCollectionViewController.h"
#import "UICollectionView+Empty.h"
#import "EDUGroupCourseListDataModels.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Scroll.h"
#import "JSONHttpClient.h"
#import "PFNavigationDropdownMenu.h"
#import "AHViewController.h"
#import "UIViewController+SimulateContainer.h"
#import "HZYListTabBar.h"
#import "EDUTagListDataModels.h"

@interface GroupCourseListVC1 ()<HZYListTabBarDelegate>

@property (nonatomic,strong) EDUGroupCourseListBaseClass* model;
@property (nonatomic, strong) AHViewController *tagVC;
@property (nonatomic,strong) HZYListTabBar *listTabBar;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSString *tagID;
@property (nonatomic,strong) NSMutableDictionary *tileTagDic;

@property (nonatomic,strong) UIButton *moreButton;
@end

@implementation GroupCourseListVC1

static NSString * const reuseIdentifier = @"group_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"";
    
    self.collectionView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //
        
        NSMutableDictionary* para = [[NSMutableDictionary alloc] init];
        [para setObject:[[NSNumber numberWithDouble:[Configuration Instance].current_group_id] stringValue] forKey:@"group_id"];
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resGroupCourseList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [[EDUGroupCourseListBaseClass alloc] initWithDictionary:json];
            //            self.navigationItem.title = self.model.info.group.longTitle;
            self.navigationItem.title =  [NSString stringWithFormat:@" %@ ", self.model.info.group.longTitle ];
            
            [self.collectionView reloadData];
        }];
        return [RACSignal empty];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.model)
        self.navigationItem.title =  [NSString stringWithFormat:@" %@ ", self.model.info.group.longTitle ];
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
        UILabel *text = [cell viewWithTag:123];
        if (text) {
            text.text = item.tag;
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
        
        reusableview = headerView;
    }
    
    reusableview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    return reusableview;
}

@end

