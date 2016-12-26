//
//  FavoriteTableViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "EDUUserFavouriteDataModels.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

@interface FavoriteTableViewController ()

@property (nonatomic,strong) EDUUserFavouriteBaseClass *model;

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/sacUserFavouriteList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDUUserFavouriteBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = FALSE;
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
    static NSString *CellIdentifier = @"others_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    EDUUserFavouriteInfo *item = [self.model.info objectAtIndex:indexPath.row];
    {
        UIImageView *image = [cell viewWithTag:100];
        [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.resCourse.thumb] URLEncodedStringFix]]];
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.resCourse.title;
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = item.resCourse.descr;
    }
    {
        UILabel *text = [cell viewWithTag:130];
        //        text.text = [NSString stringWithFormat:@"%2.2f",item.duration];
        text.text = item.resCourse.timeShow;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDUUserFavouriteInfo *item = [self.model.info objectAtIndex:indexPath.row];
    [Configuration Instance].current_course_id = item.resCourse.resCourseIdentifier;
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

@end
