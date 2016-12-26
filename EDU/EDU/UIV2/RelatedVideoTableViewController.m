//
//  RelatedVideoTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RelatedVideoTableViewController.h"
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

@interface RelatedVideoTableViewController ()
{
    NSInteger showTaskCount; //3
}

@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation RelatedVideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showTaskCount = 3;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationItem.backBarButtonItem setWidth:20];
    });
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[RACSignal combineLatest:@[RACObserve(self, model)] reduce:^id{
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model) {
        if (self.model.info) {
            if (self.model.info.others) {
                return [self.model.info.others count]; //1 for label cell
            }
        }
    }
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"others_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(self.model)
    {
        
//        if(indexPath.row==0)
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"label_cell"];
//        }
//        else
        {
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
                text.text = item.descr;
            }
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailOthers *item = [self.model.info.others objectAtIndex:indexPath.row];
    [Configuration Instance].current_course_id = item.othersIdentifier;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
    
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];
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
