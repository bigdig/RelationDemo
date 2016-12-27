//
//  FMRelationViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/21.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMRelationViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "FMRelationListDataModels.h"
#import "UIImageView+WebCache.h"
#import "Toast.h"
#import "UIScrollView+Scroll.h"
#import "UIButton+SetCropImage.h"

#import "FMAutoConnectRelation.h"
#import "FMMessageViewController.h"

@interface FMRelationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) FMRelationListBaseClass *model;

@property (nonatomic,strong) FMAutoConnectRelation *autoConnectRelation;

@end

@implementation FMRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.autoConnectRelation = [[FMAutoConnectRelation alloc] init];
    [[self.autoConnectRelation.command.executionSignals switchToLatest] subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            //show ralation
            [[[Toast alloc] initWithMessage:info] show];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
        }
    }];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/faRelationListByUser.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [FMRelationListBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
            
            [self.autoConnectRelation.command execute:nil];
            
            
        }];
        
        return [RACSignal empty];
    }];
    
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)] subscribeNext:^(RACTuple *x) {
        NSIndexPath *indexPath = x.second;
        FMRelationListRelation *item = [self.model.info.relation objectAtIndex:indexPath.row];
        if (item.faUser == nil|| item.faUser.faUserIdentifier<0.01) {
            
            FMMessageViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMMessageViewController"];
            ctl.phone = item.mobile;
            ctl.callName = item.relationWithMe;
            ctl.name = item.name;
            [self.navigationController pushViewController:ctl animated:YES];
        }
        
    }];
    
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
    return [self.model.info.relation count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"relation_cell";
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
    
    FMRelationListRelation *item = [self.model.info.relation objectAtIndex:indexPath.row];
    {
        UIImageView *image = [cell viewWithTag:100];
        [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.pic] URLEncodedStringFix]]];
    }
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = [NSString stringWithFormat:@"%@ (%@)", item.relationWithMe, item.name];
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = item.birthdayShow;
    }
    {
        UILabel *text = [cell viewWithTag:130];
        text.text = item.mobile;
    }
    {
        UILabel *text = [cell viewWithTag:140];
        if (item.faUser == nil || item.faUser.faUserIdentifier<0.01) {
            text.text = @"邀请补充";
        }
        else
        {
            text.text = @"";
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
