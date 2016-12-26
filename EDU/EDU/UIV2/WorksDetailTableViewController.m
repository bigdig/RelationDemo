//
//  WorksDetailTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "WorksDetailTableViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "EDUWorksGetDataModels.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

#import "UIButton+Badge.h"
#import "UIButton+ZanAnimation.h"
#import "UIImage+Tint.h"
#import "UIButton+SetCropImage.h"

#import "KRVideoPlayerController.h"
#import "ZYShareView.h"

@interface WorksDetailTableViewController ()

@property (nonatomic,strong) EDUWorksGetBaseClass * model;
@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation WorksDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = [Configuration Instance].current_video_url_title;
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{
                              @"work_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_work_id] stringValue]
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/shaWorksGet.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDUWorksGetBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    
        UIView *v = self.tableView.tableHeaderView;
        CGRect fr = v.frame;
        fr.size.height = 1;
        v.frame = fr;
        [self.tableView updateConstraintsIfNeeded];
    
    //    NSDictionary* para= @{@"user_id": /**[Configuration Instance].userID*/@"9",
    //                          @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
    //                          };
    //
    //    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resCourseDetail.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
    //        //
    //        self.model = [CourseDetailBaseClass modelObjectWithDictionary:json];
    //        [self.tableView reloadData];
    //    }];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = FALSE;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"detail_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        EDUWorksGetInfo *item = self.model.info;
        {
            UIImageView *image = [cell viewWithTag:100];
            [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
            //            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
        }
        {
            UILabel *text = [cell viewWithTag:110];
            text.text = item.title;
        }
        {
            UILabel *text = [cell viewWithTag:120];
            text.text = item.timeShow;
        }
        {
            UILabel *text = [cell viewWithTag:130];
            text.text = item.descr;
        }
        
        //like
        {
            UIButton *btn = [cell viewWithTag:210];
            UIImage *img = [[UIImage imageNamed:@"btn_love"] imageWithTintColor:COLOR_RED];
            [btn setImage:img forState:UIControlStateSelected];
            //btn.selected = item.hasFavourite;
            btn.selected = false;
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                /**
                NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                                      @"course_id":  [[NSNumber numberWithDouble:item.courseIdentifier] stringValue]
                                      };
                
                NSString *interface = @"recCourseFavoriteAddWt.json";
                if (btn.selected) {
                    interface = @"recCourseFavoriteDelWt.json";
                }
                
                [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,interface] params:para completion:^(id json, JSONModelError *err) {
                    //
                    btn.selected = !btn.selected;
                    //                    [btn setBadgeWithNumber:100];
                    [btn zanAnimation];
                }];
                 */
                return [RACSignal empty];
            }];
                 
        }
        
        {
            UIButton *btn = [cell viewWithTag:200];
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                
                [Configuration Instance].current_video_url = item.url;
                
//                NSMutableArray *records = [[NSMutableArray alloc] init];
//                [records addObject:[item dictionaryRepresentation]];
//                [records addObjectsFromArray:[Configuration Instance].historyPlayRecords];
//                [Configuration Instance].historyPlayRecords = records;
//                
//                QQPlayViewController *vc = [[QQPlayViewController alloc] init];
//                [self.navigationController showViewController:vc sender:nil];
                
                //play
                {
                    NSDictionary* para= @{@"user_id" :[Configuration Instance].userID,
                                          @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
                                          };
                    
                    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/recCoursePlayHisWt.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                    }];
                }
                
                if ([[[Configuration Instance] current_video_url] hasSuffix:@"mp4"]) {
                    [self playVideoWithURL: [NSURL URLWithString:[[Configuration Instance].current_video_url urlDecode]]  ];
                }
                else
                {
                    QQPlayViewController *vc = [[QQPlayViewController alloc] init];
                    [self.navigationController showViewController:vc sender:nil];
                }
                
                return [RACSignal empty];
                
                
            }];
        }
        
        {
            UIButton *btn = [cell viewWithTag:201];
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                
                UIImageView *image = [cell viewWithTag:100];
                
                __weak typeof(self) weakSelf = self;
                
                
                // 创建代表每个按钮的模型
                ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给朋友"
                                                           icon:@"Action_Share"
                                                        handler:^{
                                                            [BCWXShareProvider shareWebPage:BCWX_SESSION withTitle:item.title text:item.descr image:image.image webUrl:SHARE_URL complete:^(BOOL suc, NSString *errMsg) {
                                                                ;
                                                            }];
                                                            
                                                        }];
                
                ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                                           icon:@"Action_Moments"
                                                        handler:^{
                                                            
                                                            [BCWXShareProvider shareWebPage:WXSceneTimeline withTitle:item.title text:item.descr image:image.image webUrl:SHARE_URL complete:^(BOOL suc, NSString *errMsg) {
                                                                ;
                                                            }];
                                                            
                                                            
                                                        }];
                NSArray *shareItemsArray = @[item0, item1];
                NSArray *functionItemsArray = nil;
                
                // 创建shareView
                ZYShareView *shareView = [ZYShareView shareViewWithShareItems:shareItemsArray
                                                                functionItems:functionItemsArray];
                // 弹出shareView
                [shareView show];
                
                return [RACSignal empty];
            }];
        }
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"others_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        /**
        CourseDetailOthers *item = [self.model.info.others objectAtIndex:indexPath.row];
        {
            UIImageView *image = [cell viewWithTag:100];
            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
        }
        {
            UILabel *text = [cell viewWithTag:110];
            text.text = item.title;
        }
        {
            UILabel *text = [cell viewWithTag:120];
            text.text = item.auth;
        }
         */
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
    if (indexPath.section == 1) {
        CourseDetailOthers *item = [self.model.info.others objectAtIndex:indexPath.row];
        [Configuration Instance].current_course_id = item.othersIdentifier;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
        
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];
    }
     */
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


- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
        
        [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(id x) {
            [weakSelf.videoController stop];
            [weakSelf.videoController dismiss];
        }];
    }
    self.videoController.contentURL = url;
}

@end
