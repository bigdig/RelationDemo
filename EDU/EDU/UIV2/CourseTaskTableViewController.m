//
//  CourseTaskTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/5.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "CourseTaskTableViewController.h"
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

@interface CourseTaskTableViewController ()
{
}

@property (nonatomic,strong) EDUCourseTaskBaseClass *task;

@end

@implementation CourseTaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

        //course Task
        {
            NSDictionary* para= @{
                                  @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
                                  };
            
            [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resCourseTaskList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                //
                self.task = [EDUCourseTaskBaseClass modelObjectWithDictionary:json];
                [self.tableView reloadData];
            }];
        }
        return [RACSignal empty];
    }];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.task.info count]) {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"task_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSInteger count = [self.task.info count];
    __block NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    
    __block NSString *title = @"";
    [self.task.info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        EDUCourseTaskInfo *info = obj;
        
        //@"第一课时"
        if (![info.title isEqualToString:title]) {
            title = info.title;
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:title];
            one.yy_font = [UIFont boldSystemFontOfSize:13];
            one.yy_color = [UIColor blackColor];
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        if(info.question)
        {
            //1､这部剧有几个角色？
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:info.question  ];
            one.yy_font = [UIFont boldSystemFontOfSize:12];
            one.yy_color = [UIColor lightGrayColor];
            [text appendAttributedString:one];
            
//            if (info.answerShow)
//            {
//                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"显示答案"];
//                one.yy_font = [UIFont boldSystemFontOfSize:12];
//                one.yy_color = COLOR_LITLE_GREE;
//                
//                YYTextHighlight *highlight = [YYTextHighlight new];
//                [highlight setColor:[UIColor whiteColor]];
////                [highlight setBackgroundBorder:highlightBorder];
//                highlight.tapAction = ^(UIView *containerView, NSAttributedString *text1, NSRange range, CGRect rect) {
//                    //[_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//                    if (info.state>90) {
//                        info.state -= 90;
//                    }
//                    else
//                        info.state += 90;
//                    
//                    [self.tableView reloadData];
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//                    [self.tableView scrollToRowAtIndexPath:indexPath
//                                         atScrollPosition:UITableViewScrollPositionTop
//                                                 animated:YES];
//                };
//                [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
//                
//                [text appendAttributedString:one];
//            }
            
            if (info.answerShow)
            {
                UIImage *image = [UIImage imageNamed:info.state<90.0?@"查看答案":@"查看答案_C"];
                image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
                UIFont *font = [UIFont systemFontOfSize:12.0];
                NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                
                //add tap action
                {
                    YYTextHighlight *highlight = [YYTextHighlight new];
                    [highlight setColor:[UIColor whiteColor]];
                    //                [highlight setBackgroundBorder:highlightBorder];
                    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text1, NSRange range, CGRect rect) {
                        //[_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
                        if (info.state>90) {
                            info.state -= 90;
                        }
                        else
                            info.state += 90;
                        
                        [self.tableView reloadData];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        [self.tableView scrollToRowAtIndexPath:indexPath
                                              atScrollPosition:UITableViewScrollPositionTop
                                                      animated:YES];
                    };
                    [attachText yy_setTextHighlight:highlight range:attachText.yy_rangeOfAll];
                }
                
                [text appendAttributedString:attachText];
            }
            
            [text appendAttributedString:[self padding]];
            
            if (info.answerShow && info.state>90.0)
            {
                //@"  【答案：3个】"
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"    %@", info.answerShow]];
                one.yy_font = [UIFont boldSystemFontOfSize:12];
                one.yy_color = [UIColor lightGrayColor];
                [text appendAttributedString:one];
                [text appendAttributedString:[self padding]];
            }
            
        }
        
//        if (info.answerShow)
//        {
//            //@"  【答案：3个】"
//            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  答：%@", info.answerShow]];
//            one.yy_font = [UIFont boldSystemFontOfSize:10];
//            one.yy_color = [UIColor lightGrayColor];
//            [text appendAttributedString:one];
//            [text appendAttributedString:[self padding]];
//        }
    }];
    
    
    YYLabel *label = [cell viewWithTag:100];
    label.attributedText = text;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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


- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.yy_font = [UIFont systemFontOfSize:10];
    return pad;
}

@end
