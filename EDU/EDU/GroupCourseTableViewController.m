//
//  GroupCourseTableViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "GroupCourseTableViewController.h"
#import "EDUGroupCourseDataModels.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

#import "UIButton+Badge.h"
#import "UIButton+ZanAnimation.h"
#import "UIImage+Tint.h"
#import "UIButton+SetCropImage.h"

@interface GroupCourseTableViewController ()

@property (nonatomic,strong) EDUGroupCourseBaseClass *model;

@end

@implementation GroupCourseTableViewController


static NSString * const reuseIdentifier = @"group_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
/**
    self.navigationController.navigationBar.translucent = YES;
    //    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    //remove shadow
    self.navigationController.navigationBar.clipsToBounds = YES;
*/    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              @"group_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_group_id] stringValue]
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resGroupCourseList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDUGroupCourseBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = FALSE;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

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
    return [self.model.info.courseList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"detail_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        EDUGroupCourseGroup *item = self.model.info.group;
        {
            UIImageView *image = [cell viewWithTag:100];
            [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.titlePic] URLEncodedStringFix]]];
//            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.titlePic] URLEncodedStringFix]]];
        }
        {
            UILabel *text = [cell viewWithTag:110];
            text.text = item.title;
        }
        {
            UILabel *text = [cell viewWithTag:120];
            text.text = item.totalTimeShow;
        }
        {
            UILabel *text = [cell viewWithTag:130];
            text.text = item.descr;
        }
        
        //like
//        {
//            UIButton *btn = [cell viewWithTag:210];
//            UIImage *img = [[UIImage imageNamed:@"btn_love"] imageWithTintColor:COLOR_RED];
//            [btn setImage:img forState:UIControlStateSelected];
//            btn.selected = item.hasFavourite;
//            @weakify(self);
//            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                //
//                @strongify(self);
//                NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
//                                      @"course_id":  [[NSNumber numberWithDouble:item.courseIdentifier] stringValue]
//                                      };
//                
//                NSString *interface = @"recCourseFavoriteAddWt.json";
//                if (btn.selected) {
//                    interface = @"recCourseFavoriteDelWt.json";
//                }
//                
//                [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,interface] params:para completion:^(id json, JSONModelError *err) {
//                    //
//                    btn.selected = !btn.selected;
//                    //                    [btn setBadgeWithNumber:100];
//                    [btn zanAnimation];
//                }];
//                return [RACSignal empty];
//            }];
//        }
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"others_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        EDUGroupCourseCourseList *item = [self.model.info.courseList objectAtIndex:indexPath.row];
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
        {
            UILabel *text = [cell viewWithTag:130];
            text.text = [NSString stringWithFormat:@"%2.2f",item.duration];
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        EDUGroupCourseCourseList *item = [self.model.info.courseList objectAtIndex:indexPath.row];
        [Configuration Instance].current_course_id = item.courseListIdentifier;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
        
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
