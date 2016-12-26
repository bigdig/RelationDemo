//
//  SubjectViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/14.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "SubjectViewController.h"
#import "UICollectionView+Empty.h"
#import "EDUResGroupListDataModels.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Scroll.h"
#import "JSONHttpClient.h"

@interface SubjectViewController ()

@property (nonatomic,strong) EDUResGroupListBaseClass* model;

@end

@implementation SubjectViewController


static NSString * const reuseIdentifier = @"group_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    
    self.collectionView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resGroupList.json",BASEURL] params:nil completion:^(id json, JSONModelError *err) {
            //
            self.model = [[EDUResGroupListBaseClass alloc] initWithDictionary:json];
            [self.collectionView reloadData];
        }];
        return [RACSignal empty];
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
    return [self.model.info count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    EDUResGroupListInfo *item = [self.model.info objectAtIndex:indexPath.row];
    
    {
        UIImageView *image = [cell viewWithTag:100];
        
        [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.icon] URLEncodedStringFix]]];
        
        UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:myTapGesture];
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.title;
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = @"";
    }
    
    {
        UILabel *text = [cell viewWithTag:130];
        text.text = @"";
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
    float unit = ([UIScreen mainScreen].bounds.size.width-4)/4;
    
    return CGSizeMake(unit, unit*1.2);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
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
    EDUResGroupListInfo *item = [self.model.info objectAtIndex:indexPath.row];
    
    
    [Configuration Instance].current_group_id = item.infoIdentifier;
    
    if (item.infoIdentifier - 23<0.001 || item.infoIdentifier - 24<0.001 || item.infoIdentifier - 25<0.001 ) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListCollectionViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"firstpage" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GroupCourseListVC1"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
