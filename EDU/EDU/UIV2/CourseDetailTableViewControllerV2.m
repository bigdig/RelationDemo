//
//  CourseDetailTableViewControllerV2.m
//  EDU
//
//  Created by renxingguo on 2016/12/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "CourseDetailTableViewControllerV2.h"
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


//#define KHeaderViewHeight  211
#define KHeaderViewHeight  1
#define KSegmentBarHeight  44

#import "ViewController.h"
#import "MCStopView.h"
#import "MCTableViewController.h"
#import "MCContentCollectionView.h"
#import "UINavigationBar+Background.h"

#import "RelatedVideoTableViewController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface CourseDetailTableViewControllerV2 ()
{
    MCTableViewController * TableView;
    MCTableViewController * TableView2;
    
    MCContentCollectionView * CollectionView;
    UIImageView *imgview ;
    
    RelatedVideoTableViewController *vc1;
    UIView *headerView;
}

@property (nonatomic,strong) CourseDetailBaseClass * model;
@property (nonatomic,strong) EDUCourseTaskBaseClass *task;

@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation CourseDetailTableViewControllerV2


- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerView = [[UIView alloc] init];

    const float playerH = Main_Screen_Width*9/16;
    
    MCStopView * stopView = [[MCStopView alloc]initWithFrame:CGRectMake(0, playerH,Main_Screen_Width , Main_Screen_Height-KHeaderViewHeight-playerH-44-64) HeaderViewHeight:KHeaderViewHeight SegmentBarHeight:KSegmentBarHeight HeaderView:[self prepareHeaderView] ContentViews:[self prepareContentViews] SegmentsTitles:@[@"Seg1",@"Seg2",@"Seg3"] HeaderImg:imgview];
    
    
    [self.view addSubview:stopView];
    
//    self.bottomLayout.constant = -44;
//    self.floatView.backgroundColor = [UIColor greenColor];
    [self.floatView layoutIfNeeded];
    [self.view bringSubviewToFront:self.floatView];
    
    {
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
    }
    
    
    [RACObserve(self, model)  subscribeNext:^(id x) {
        if (self.model) {
            vc1.model = self.model;
            
            CourseDetailCourse *item = self.model.info.course;
            {
                UIImageView *image = [self.view viewWithTag:100];
                [image setCropImageForNormalState:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
                //            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",Prefix, item.thumb] URLEncodedStringFix]]];
                
                @weakify(self);
                [RACObserve(self, videoController) subscribeNext:^(id x) {
                    @strongify(self);
                    UIButton *btn = [[self prepareHeaderView] viewWithTag:200];
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
            
            
            //like
            {
                UIButton *btn = self.loveButton;
//                UIImage *img = [[UIImage imageNamed:@"btn_love"] imageWithTintColor:COLOR_LITLE_GREE];
//                [btn setImage:img forState:UIControlStateSelected];
                [btn setTitleColor:COLOR_LITLE_BLUE forState:UIControlStateSelected];
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
            
            //praise
            {
                UIButton *btn = self.praiseButton;
//                UIImage *img = [[UIImage imageNamed:@"btn_praise"] imageWithTintColor:COLOR_LITLE_GREE];
//                [btn setImage:img forState:UIControlStateSelected];
                [btn setTitleColor:COLOR_LITLE_BLUE forState:UIControlStateSelected];
                if (self.model.info.course.zan>1.0) {
                    btn.selected = TRUE;
                }
                
                NSString * title = [NSString stringWithFormat:@"%0.0f 次赞",self.model.info.course.zan];
                [btn setTitle:title forState:UIControlStateNormal];
                
                @weakify(self);
                btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    //
                    @strongify(self);
                    NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                                          @"course_id":  [[NSNumber numberWithDouble:item.courseIdentifier] stringValue]
                                          };
                    
                    NSString *interface = @"resCourseZanWt.json";
                    
                    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,interface] params:para completion:^(id json, JSONModelError *err) {
                        //
                        btn.selected = TRUE;
                        NSString * title = [NSString stringWithFormat:@"%0.0f 次赞",self.model.info.course.zan+1];
                        [btn setTitle:title forState:UIControlStateNormal];
                        [btn zanAnimation];
                    }];
                    return [RACSignal empty];
                }];
            }
            
            {
                UIButton *btn = self.shareButton;
                @weakify(self);
                btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                    //
                    @strongify(self);
                    
                    __weak typeof(self) weakSelf = self;
                    
                    
                    
                    UIImageView *image = [self.view viewWithTag:100];;
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
                    
                    ZYShareItem *item4 = [ZYShareItem itemWithTitle:@"QQ"
                                                               icon:@"Action_QQ"
                                                            handler:^{
                                                                
                                                                //创建分享消息对象
                                                                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                                                                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:item.title descr:item.descr thumImage:image.image];
                                                                //设置视频网页播放地址
                                                                shareObject.webpageUrl = SHARE_URL;
                                                                //分享消息对象设置分享内容对象
                                                                messageObject.shareObject = shareObject;
                                                                
                                                                //调用分享接口
                                                                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                                                                    /*
                                                                     if (error) {
                                                                     NSLog(@"************Share fail with error %@*********",error);
                                                                     }else{
                                                                     NSLog(@"response data is %@",data);
                                                                     }
                                                                     */
                                                                }];
                                                                
                                                            }];
                    
                    
                    NSArray *shareItemsArray = @[item0, item1, item4];
                    NSArray *functionItemsArray = nil;
                    
                    // 创建shareView
                    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:shareItemsArray
                                                                    functionItems:functionItemsArray];
                    // 弹出shareView
                    [shareView show];
                    return [RACSignal empty];
                }];
            }

            
            @weakify(self);
            self.playButton.clipsToBounds = YES;
            self.playButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
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
    }];
    
    
    //dismiss keyboard
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tap];
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            [self.view endEditing:TRUE];
        }];
    }
    
}
-(UIView*)prepareHeaderView{
    
    return headerView;
}

-(NSMutableArray*)prepareContentViews{
    NSMutableArray * array = [NSMutableArray
                              array];

    
    
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"xx1"];
        [array addObject:vc1.view];
        [self addChildViewController:vc1];
    }
    
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CourseCommentTableViewController"];
        [array addObject:vc.view];
        [self addChildViewController:vc];
    }
    
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskTableViewController"];
        [array addObject:vc.view];
        [self addChildViewController:vc];
    }
    
    

//    {
//        TableView2 = [MCTableViewController contentTableViewFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - KSegmentBarHeight - 64)];
//        [array addObject:TableView2];
//    }
//    
//    TableView2 = [MCTableViewController contentTableViewFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - KSegmentBarHeight - 64)];
//    [array addObject:TableView2];
    return array;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
