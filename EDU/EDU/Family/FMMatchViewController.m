//
//  FMMatchViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/26.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMMatchViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "FMRelationListDataModels.h"
#import "UIImageView+WebCache.h"
#import "Toast.h"
#import "UIScrollView+Scroll.h"
#import "UIButton+SetCropImage.h"
#import "YYText/YYText.h"
#import "JSONHTTPClient.h"
#import "FMuserEntityDataModels.h"
#import "NSString+AttributeString.h"

@interface FMMatchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) FMRelationListBaseClass *model;

@end

@implementation FMMatchViewController

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
    
    //add head
    {
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"根据手机"  ];
        one.yy_font = [UIFont boldSystemFontOfSize:13];
        one.yy_color = [UIColor darkGrayColor];
        [text appendAttributedString:one];
        
        NSMutableAttributedString *phone = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [Configuration Instance].phoneNumber]];
        phone.yy_font = [UIFont boldSystemFontOfSize:13];
        phone.yy_color = [UIColor colorWithRed:17/255.0 green:149/255.0 blue:217/255.0 alpha:1.0];
        [text appendAttributedString:phone];
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"进行匹配"  ];
            one.yy_font = [UIFont boldSystemFontOfSize:13];
            one.yy_color = [UIColor darkGrayColor];
            [text appendAttributedString:one];
        }
        
        self.headLabel.attributedText = text;
    }
    
    self.meButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //update profile
        UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMProfileTableViewController"];
        [self.navigationController pushViewController:ctl animated:YES];
        return [RACSignal empty];
    }];
    
    self.notMeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //create profile
        //新建实体用户(已有实体不是自己的情况使用)
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/wtFaEntityUserCreat.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMProfileTableViewController"];
            [self.navigationController pushViewController:ctl animated:YES];
        }];
        return [RACSignal empty];
    }];
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/faRelationListByUser.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [FMRelationListBaseClass modelObjectWithDictionary:json];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    self.tableView.tableFooterView = self.footView;
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
    return [self.model.info.relation count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"relation_cell";
    UITableViewCell *cell = nil;
    
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
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
        {
            UIImageView *image = [cell viewWithTag:100];
            [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, [Configuration Instance].avatar] URLEncodedStringFix]]];
        }
        {
            YYLabel *text = [cell viewWithTag:110];
            text.attributedText = [NSString getNameSex:[Configuration Instance].userName sex:[[Configuration Instance].sex integerValue] ];
        }
        {
            UILabel *text = [cell viewWithTag:120];
            text.text = [Configuration Instance].birthday;
        }
        {
            UILabel *text = [cell viewWithTag:130];
            text.text = [Configuration Instance].phoneNumber;
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        FMRelationListRelation *item = [self.model.info.relation objectAtIndex:indexPath.row - 1];
        {
            UIImageView *image = [cell viewWithTag:100];
            [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.pic] URLEncodedStringFix]]];
        }
        {
            YYLabel *text = [cell viewWithTag:110];
            NSString * info = [NSString stringWithFormat:@"%@(%@)", item.relationWithMe, item.name];
            text.attributedText = [NSString getNameSex:info sex:item.sex];
        }
        {
            UILabel *text = [cell viewWithTag:120];
            text.text = item.birthdayShow;
        }
        {
            UILabel *text = [cell viewWithTag:130];
            text.text = item.mobile;
        }
    }
    
    

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
