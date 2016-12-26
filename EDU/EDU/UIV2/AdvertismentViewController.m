//
//  AdvertismentViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "AdvertismentViewController.h"
#import "JSONHTTPClient.h"
#import "EDUAdDataModels.h"

#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

@interface AdvertismentViewController ()
@property (nonatomic,strong) NSArray *model;
@end

@implementation AdvertismentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/ad/1.json",Prefix] params:nil completion:^(id json, JSONModelError *err) {
        //
        self.model = [EDUAdBaseClass modelObjectWithDictionary:json].info;
        [self initUI];
    }];
}

-(void)initUI{
    
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ADVERTISMENT_HEIGHT)];
    [self.view addSubview:imageView];
    
    for (int i = 0; i < [_model count]; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, ADVERTISMENT_HEIGHT)];
        
        EDUAdInfo* data = [_model objectAtIndex:i];
        NSString* url = [NSString stringWithFormat:@"%@/%@",Prefix, data.pic  ];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [viewsArray addObject:imageView];
    }
    
    
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ADVERTISMENT_HEIGHT) animationDuration:2];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    @weakify(self);
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        @strongify(self);
        return [self.model count];
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        //todo
        @strongify(self);
        
        EDUAdInfo *ad = [self.model objectAtIndex:pageIndex];
        if ([[ad url] length]) {
            [Configuration Instance].current_video_url = [NSString stringWithFormat:@"%@?user_id=%@", ad.url, [Configuration Instance].userID];
            NSLog(@"%@", [Configuration Instance].current_video_url);
            if ([ad.title length]) {
                [Configuration Instance].current_video_url_title = ad.title;
            }
            else
                [Configuration Instance].current_video_url_title = @"";
            
            QQPlayViewController *vc = [[QQPlayViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    };
    [self.view addSubview:self.mainScorllView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
