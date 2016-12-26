//
//  ArticlesListViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/13.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "ArticlesListViewController.h"

#import "FirstViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Scroll.h"

#import "EDUArticlesListByClsIdDataModels.h"

@interface ArticlesListViewController ()

@property (nonatomic,strong) EDUArticlesListByClsIdBaseClass* model;

@end

@implementation ArticlesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    @weakify(self);
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        NSDictionary* para  = @{};
        if ([self.cls_id length] != 0) {
            para= @{@"cls_id": self.cls_id
                                  };
        }

        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/shaArticlesListByClsId.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDUArticlesListByClsIdBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    
    UIView *v = self.tableView.tableHeaderView;
    CGRect fr = v.frame;
    fr.size.height = 33;
    v.frame = fr;
    [self.tableView updateConstraintsIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.info count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"course_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    EDUArticlesListByClsIdInfo *item = [self.model.info objectAtIndex:indexPath.row];
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
        UILabel *text = [cell viewWithTag:120];
        text.text = @"";
    }
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)imageViewClicked:(UITapGestureRecognizer*)gestRecognizer
{
    UIImageView* iv = (UIImageView*)gestRecognizer.view;
    NSInteger tag = iv.tag; // then do what you want with this
    
    // or get the cell by going up thru the superviews until you find it
    UIView* cellView = iv;
    while(cellView && ![cellView isKindOfClass:[UITableViewCell class]])
        cellView = cellView.superview; // go up until you find a cell
    
    // Then get its indexPath
    UITableViewCell* cell = (UITableViewCell*)cellView;
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    EDUArticlesListByClsIdInfo *item = [self.model.info objectAtIndex:indexPath.row];
    
    [Configuration Instance].current_video_url = item.url;
    [Configuration Instance].current_video_url_title = item.title;
    QQPlayViewController *vc = [[QQPlayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
