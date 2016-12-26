//
//  CourseDetailTableViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/1.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "CourseDetailDataModels.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

#import "UIButton+Badge.h"
#import "UIButton+ZanAnimation.h"
#import "UIImage+Tint.h"
#import "UIButton+SetCropImage.h"

#import "EDUCourseTaskDataModels.h"
#import "UIButton+Expand.h"

#import "KRVideoPlayerController.h"
#import "ZYShareView.h"

#import "YYText/YYText.h"

@interface CourseDetailTableViewController ()
{
    NSInteger showTaskCount; //3
}

@property (nonatomic,strong) CourseDetailBaseClass * model;
@property (nonatomic,strong) EDUCourseTaskBaseClass *task;

@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation CourseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showTaskCount = 3;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    /**
     self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    //remove shadow
    self.navigationController.navigationBar.clipsToBounds = YES;
     */
//    CGRect frame = self.navigationItem.leftBarButtonItem.customView.frame;
//    frame.size.width = 50;
//    self.navigationItem.leftBarButtonItem.customView.frame = frame;
//    self.navigationItem.title = @"视频详情";
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationItem.backBarButtonItem setWidth:20];
    });
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resCourseDetail.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [CourseDetailBaseClass modelObjectWithDictionary:json];
        }];
        
        //course Task
        {
            NSDictionary* para= @{
                                  @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
                                  };
            
            [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resCourseTaskList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                //
                self.task = [EDUCourseTaskBaseClass modelObjectWithDictionary:json];
            }];
        }
        return [RACSignal empty];
    }];
    
    
    [[RACSignal combineLatest:@[RACObserve(self, model), RACObserve(self, task)] reduce:^id{
        return [RACSignal empty];
    }] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
//    UIView *v = self.tableView.tableHeaderView;
//    CGRect fr = v.frame;
//    fr.size.height = 1;
//    v.frame = fr;
//    [self.tableView updateConstraintsIfNeeded];
    
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
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    if (section==1) {
        if ([self.task.info count]) {
            return 1;
        }
        return 0;
    }
    if (self.model) {
        if (self.model.info) {
            if (self.model.info.others) {
                return [self.model.info.others count] + 1; //1 for label cell
            }
        }
    }
    return 0;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"detail_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        CourseDetailCourse *item = self.model.info.course;
        {
            UIImageView *image = [cell viewWithTag:100];
            [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
//            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
            
            @weakify(self);
            [RACObserve(self, videoController) subscribeNext:^(id x) {
                @strongify(self);
                UIButton *btn = [cell viewWithTag:200];
                if(self.videoController)
                {
                    [image setAlpha:0.0];
                    [btn  setAlpha:0.0];
                }
                else
                {
                    [image setAlpha:1.0];
                    [btn  setAlpha:1.0];
                }
            }];
             
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
            [btn setEnlargeEdge:10];
            UIImage *img = [[UIImage imageNamed:@"btn_love"] imageWithTintColor:COLOR_RED];
            [btn setImage:img forState:UIControlStateSelected];
            btn.selected = item.hasFavourite;
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
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
                return [RACSignal empty];
            }];
        }
        
        //comment
        {
            UIButton *btn = [cell viewWithTag:220];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setEnlargeEdge:10];
            //todo set comment number
            NSString *title = [NSString stringWithFormat:@"(%@)",[NSNumber numberWithDouble:self.model.info.commentNum].stringValue];
            [btn setTitle: title forState:UIControlStateNormal];
            
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                //todo comment
                
                [Configuration Instance].current_course_id = item.courseIdentifier;
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
                
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseCommentViewController"];
                
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:vc animated:YES];
                return [RACSignal empty];
            }];
        }
        
        {
            UIButton *btn = [cell viewWithTag:200];
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                
                if ([[Configuration Instance].school length]==0 || [[Configuration Instance].school length]==0) {
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"V2LoginStoryboard" bundle:nil];
                    
                    UIViewController *profile = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                    
                    [self.navigationController pushViewController:profile animated:YES];
                }
                else
                {
                    [Configuration Instance].current_video_url = item.url;
                    //                NSMutableArray *records = [[NSMutableArray alloc] init];
                    //                [records addObject:[item dictionaryRepresentation]];
                    //                [records addObjectsFromArray:[Configuration Instance].historyPlayRecords];
                    //                [Configuration Instance].historyPlayRecords = records;
                    
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
                }

                return [RACSignal empty];
            }];
        }
        
        {
            UIButton *btn = [cell viewWithTag:201];
            [btn setEnlargeEdge:10];
            @weakify(self);
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //
                @strongify(self);
                
                __weak typeof(self) weakSelf = self;
                

                
                UIImageView *image = [cell viewWithTag:100];
                //http://edu.dressbook.cn/share/download.html
                
                // 创建代表每个按钮的模型
                ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给朋友"
                                                           icon:@"Action_Share"
                                                        handler:^{
                                                            [BCWXShareProvider shareWebPage:BCWX_SESSION withTitle:item.title text:item.descr image:image.image webUrl:@"http://edu.dressbook.cn/share/download.html" complete:^(BOOL suc, NSString *errMsg) {
                                                                ;
                                                            }];
                                                            
                                                        }];
                
                ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                                           icon:@"Action_Moments"
                                                        handler:^{
                                                            
                                                            [BCWXShareProvider shareWebPage:WXSceneTimeline withTitle:item.title text:item.descr image:image.image webUrl:@"http://edu.dressbook.cn/share/download.html" complete:^(BOOL suc, NSString *errMsg) {
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
    else if(indexPath.section==10) //deprecate
    {
        static NSString *CellIdentifier = @"task_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        NSInteger count = [self.task.info count];
        if (count>showTaskCount) {
            count = showTaskCount;
        }
        
        
        for (int i=0; i<12; i++) {
            UILabel *text = [cell viewWithTag:100+i*10];
            text.text = count>i?[NSString stringWithFormat:@"%@、%@", [[NSNumber numberWithInt:i+1] stringValue], [[self.task.info objectAtIndex:i] question]]:@"";
        }
        
        UIButton *btn = [cell viewWithTag:300];
        btn.layer.cornerRadius = 12.5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = COLOR_LITLE_GREE.CGColor;
        btn.layer.masksToBounds = YES;
        
        @weakify(self);
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            //
            @strongify(self);
            showTaskCount = [self.task.info count];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            return [RACSignal empty];
        }];
        
        if ([self.task.info count] < 4) {
            btn.hidden = YES;
        }
        
        return cell;
    }
    else if(indexPath.section==1)
    {
        static NSString *CellIdentifier = @"task_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        NSInteger count = [self.task.info count];
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];

        
        __block NSString *title = @"";
        
        [self.task.info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            EDUCourseTaskInfo *info = obj;
            
            //@"第一课时"
            if (![info.title isEqualToString:title]) {
                title = info.title;
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:title];
                one.yy_font = [UIFont boldSystemFontOfSize:11];
                one.yy_color = [UIColor blackColor];
                [text appendAttributedString:one];
                [text appendAttributedString:[self padding]];
            }
            
            if(info.question)
            {
                //1､这部剧有几个角色？
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:info.question  ];
                one.yy_font = [UIFont boldSystemFontOfSize:10];
                one.yy_color = [UIColor lightGrayColor];
                [text appendAttributedString:one];
                [text appendAttributedString:[self padding]];
            }
            
            if (info.answerShow)
            {
                //@"  【答案：3个】"
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  答：%@", info.answerShow]];
                one.yy_font = [UIFont boldSystemFontOfSize:10];
                one.yy_color = [UIColor lightGrayColor];
                [text appendAttributedString:one];
                [text appendAttributedString:[self padding]];
            }
        }];
        
        UILabel *label = [cell viewWithTag:100];
        label.attributedText = text;
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"others_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(self.model)
        {

            if(indexPath.row==0)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"label_cell"];
            }
            else
            {
                CourseDetailOthers *item = [self.model.info.others objectAtIndex:indexPath.row - 1];
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
                    text.text = item.descr;
                }
            }

        }

        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        CourseDetailOthers *item = [self.model.info.others objectAtIndex:indexPath.row];
        [Configuration Instance].current_course_id = item.othersIdentifier;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
        
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];
    }
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


- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.yy_font = [UIFont systemFontOfSize:4];
    return pad;
}
@end
