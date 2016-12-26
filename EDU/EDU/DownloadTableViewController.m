//
//  DownloadTableViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "DownloadTableViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "EDURepositistDataModels.h"
#import "UIImageView+WebCache.h"
#import "Toast.h"
#import "UIScrollView+Scroll.h"

@interface DownloadTableViewController ()

@property (nonatomic,strong) EDURepositistBaseClass *model;

@end

@implementation DownloadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"下载";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resRepositist.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDURepositistBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.model.info.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"download_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    {
//        const int kCellBorderWidth = 10;
//        //custom card cell view
//        UIView *bg = [[UIView alloc] initWithFrame:cell.bounds];
//        bg.backgroundColor = [UIColor whiteColor];
//        bg.layer.borderColor = self.view.backgroundColor.CGColor;
//        bg.layer.borderWidth = 5;
//        bg.layer.cornerRadius= 15;
//        bg.layer.masksToBounds = YES;
//        cell.backgroundView = bg;
//    }
    
    EDURepositistList *item = [self.model.info.list objectAtIndex:indexPath.section];
    {
        UIImageView *image = [cell viewWithTag:130];
        NSString *url = [NSString stringWithFormat:@"%@%@",Prefix, item.resRepCls.icon];
        url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"" ];
        url = [url URLEncodedStringFix];
        [image sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    {
        UILabel *text = [cell viewWithTag:100];
        text.text = item.name;
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.descr;
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = [NSString stringWithFormat:@"%0.0f M",item.size];
    }
    {
        UIButton *btn = [cell viewWithTag:140];
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            //copy link, 并提示
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            NSString *url = [NSString stringWithFormat:@"%@%@",Prefix, item.path];
            [pasteboard setString:url];
            [[[Toast alloc] initWithMessage:@"下载链接已经复制，请另行下载！"] show];
            return [RACSignal empty];
        }];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDURepositistList *item = [self.model.info.list objectAtIndex:indexPath.section];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *url = [NSString stringWithFormat:@"%@%@",Prefix, item.path];
    [pasteboard setString:url];
    [[[Toast alloc] initWithMessage:@"下载链接已经复制，请另行下载！"] show];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView.scrollDelegate scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.tableView.scrollDelegate scrollViewDidEndDecelerating:scrollView];
}
@end
