//
//  CourseCommentViewController.m
//  EDU
//
//  Created by renxingguo on 2016/10/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "CourseCommentViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "EDUCourseCommentDataModels.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

#import "UIButton+Badge.h"
#import "UIButton+ZanAnimation.h"
#import "UIImage+Tint.h"
#import "UIButton+SetCropImage.h"
#import "UIImage+Mask.h"

#import "ZYKeyboardUtil.h"

@interface CourseCommentViewController ()<UITableViewDelegate,UITableViewDataSource, UITextInputDelegate>

@property (nonatomic,strong) EDUCourseCommentBaseClass * model;
@property (nonatomic,strong) ZYKeyboardUtil *keyboardUtil;

@end

@implementation CourseCommentViewController

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
    
    self.navigationItem.title = @"评论";
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSDictionary* para= @{
                              @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue]
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resCommentList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            self.model = [EDUCourseCommentBaseClass modelObjectWithDictionary:json];
            
            self.navigationItem.title = [NSString stringWithFormat:@"%@(%lu)",@"评论", (unsigned long)[self.model.info count] ];
            [self.tableView reloadData];
        }];
        
        return [RACSignal empty];
    }];
    
    //    UIView *v = self.tableView.tableHeaderView;
    //    CGRect fr = v.frame;
    //    fr.size.height = 33;
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
    
    @weakify(self);
    RACSignal *enable = [RACSignal combineLatest:@[self.commentTextView.rac_textSignal] reduce:^id{
        @strongify(self);
        return @([self.commentTextView.text length]>0);
    }];
    self.commentButton.rac_command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                              @"course_id":  [[NSNumber numberWithDouble:[Configuration Instance].current_course_id] stringValue],
                              @"words": self.commentTextView.text
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/recCommentWt.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
            //
            [self.commentTextView resignFirstResponder];
            [self.tableView.refreshCommand execute:nil];
            self.commentTextView.text = @"";
        }];
        return [RACSignal empty];
    }];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString: [Configuration Instance].avatar ]
                   placeholderImage:[[UIImage imageNamed:@"头像"] circleImage]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              if (image) {
                                  _avatar.image = [image circleImage];
                              }
                              
                          }];
    
    self.commentTextView.delegate = self;
    [self configKeyBoardRespond];
    
    //config textview placehold
    [self setupPlaceHolder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 给textView添加一个UILabel子控件
- (void)setupPlaceHolder
{
    UILabel *placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    placeHolder.text = @"  请输入:";
    placeHolder.textColor = [UIColor lightGrayColor];
    placeHolder.numberOfLines = 0;
    placeHolder.contentMode = UIViewContentModeTop;
    [self.commentTextView addSubview:placeHolder];
    
    @weakify(self);
    [self.commentTextView.rac_textSignal subscribeNext:^(id x) {
        //
        @strongify(self);
        if (!self.commentTextView.text.length) {
            placeHolder.alpha = 1;
        } else {
            placeHolder.alpha = 0;
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.model.info count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"comment_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    EDUCourseCommentInfo *item = [self.model.info objectAtIndex:indexPath.row];
    {
        NSString *path = item.sacUser.photo;
        NSString *url = [NSString stringWithFormat:@"%@/%@",Prefix, path];
        UIImageView *face = [cell viewWithTag:100];
        [face sd_setImageWithURL:[NSURL URLWithString: url ]
                placeholderImage:[[UIImage imageNamed:@"头像"] circleImage]
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           if (image) {
                               face.image = [image circleImage];
                           }
                           
                       }];
    }
    
    {
        UILabel *text = [cell viewWithTag:110];
        text.text = item.sacUser.logname;
    }
    {
        UILabel *text = [cell viewWithTag:120];
        text.text = item.addTimeShow;
    }
    
    {
        UILabel *text = [cell viewWithTag:130];
        text.text = item.words;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.commentTextView resignFirstResponder];
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


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    __weak CourseCommentViewController *weakSelf = self;

#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.commentTextView, nil];
    }];
    /*  or
     [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
     [keyboardUtil adaptiveViewHandleWithAdaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
     }];
     */
    
    
#pragma explain - 自定义键盘弹出处理(如配置，全自动键盘处理则失效)
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    /*
     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}


#pragma mark delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.commentTextView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.commentTextView resignFirstResponder];
    return YES;
}


@end
