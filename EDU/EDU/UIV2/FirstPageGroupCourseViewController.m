//
//  FirstPageGroupCourseViewController.m
//  EDU
//
//  Created by renxingguo on 2016/11/25.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FirstPageGroupCourseViewController.h"
#import "UIButton+Expand.h"
#import "UICollectionView+Empty.h"
#import "EDUGroupCourseListDataModels.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Scroll.h"
#import "JSONHttpClient.h"

@interface FirstPageGroupCourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) EDUGroupCourseListBaseClass* model;

@end

@implementation FirstPageGroupCourseViewController


static NSString * const reuseIdentifier = @"group_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    /**
     self.collectionView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
     //
     [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/shaArticlesClsList.json",BASEURL] params:nil completion:^(id json, JSONModelError *err) {
     //
     self.model = [[EDUArticlesBaseClass alloc] initWithDictionary:json];
     [self.collectionView reloadData];
     }];
     return [RACSignal empty];
     }];
     */
    
    NSDictionary* para= @{@"group_id":@"22"
                          };
    
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resGroupCourseList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
        //
        self.model = [[EDUGroupCourseListBaseClass alloc] initWithDictionary:json];
        [self.collectionView reloadData];
    }];
    

    UIButton *moreButton = [self.view viewWithTag:100];
    [moreButton setEnlargeEdge:10];
    moreButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [Configuration Instance].current_group_id = 22;
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListVC2"];
        [self.navigationController pushViewController:vc animated:YES];
        return  [RACSignal empty];
    }];
    
    {
        UIView *v = [self.view viewWithTag:99];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [v addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [moreButton.rac_command execute:nil];
        }];
    }
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
        
//        UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
//        image.userInteractionEnabled = YES;
//        [image addGestureRecognizer:myTapGesture];
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.title;
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = item.tag;
        //text.text = [NSString stringWithFormat:@"%0.0f", item.duration];
    }
    
//    {
//        UILabel *text = [cell viewWithTag:130];
//        text.text = item.timeShow;
//    }
    
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
    //float unit = ([UIScreen mainScreen].bounds.size.width-4)/2;
    float unit = 150;
    
    return CGSizeMake(unit, unit*25/30);
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EDUGroupCourseListCourseList *item = [self.model.info.courseList objectAtIndex:indexPath.row];
    
    [Configuration Instance].current_course_id = item.courseListIdentifier;
    [Configuration Instance].current_video_url_title = item.title;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
    
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
