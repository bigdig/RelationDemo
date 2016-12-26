//
//  SetTableViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "SetTableViewController.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "CourseDetailDataModels.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"
#import "UIViewController+Login.h"
#import "UIScrollView+Scroll.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Orientation.h"
#import "UIImage+UIImageScale.h"
#import "UIImage+Mask.h"

@import AFNetworking;
@import SVProgressHUD;

@interface SetTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    
    [[self rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
        self.navigationItem.title = [[Configuration Instance] userName];
    }];
    
    UIView *v = self.tableView.tableHeaderView;
    CGRect fr = v.frame;
    fr.size.height = 100;
    v.frame = fr;
    [self.tableView updateConstraintsIfNeeded];
    
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //set face image action
    {
        self.faceImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImgClicked:)];
        [singleTap setNumberOfTouchesRequired:1];
        [singleTap setNumberOfTapsRequired:1];
        [self.faceImg addGestureRecognizer:singleTap];
    }
    
    [RACObserve([Configuration Instance], avatar) subscribeNext:^(NSString* x) {
        NSLog(@"%@",x);
        [_faceImg sd_setImageWithURL:[NSURL URLWithString: x ]
                    placeholderImage:[[UIImage imageNamed:@"头像"] circleImage]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               if (image) {
                                   _faceImg.image = [image circleImage];
                               }
                               
                           }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"FavoriteTableViewController"];
            
            self.navigationController.navigationBarHidden = FALSE;
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1: //播放历史
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"HistoryPlayRecordTableViewController"];
            
            self.navigationController.navigationBarHidden = FALSE;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2: //设置
        {
            if ([self isLogin]) {
                UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyAccountViewController"];
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"document_cell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history_cell" forIndexPath:indexPath];
            return cell;
        }
            break;
            
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting_cell" forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10; //according to your need..
}

#pragma mark - **************

//点击了头像
- (IBAction)faceImgClicked:(UIImage *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    // [self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
}

//从相册选择完图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    image = [[image fixOrientation] getSubImageFitToWH:self.faceImg.frame.size.width Height:self.faceImg.frame.size.height];
    
    [self.faceImg setImage:image];
    NSDictionary* para= @{@"user_id":[[Configuration Instance] userID]
                          };
    
    [self requestPostUrlWithImage:@"sacUserPhotoUpdWt.json" parameters:para image:image success:^(NSDictionary *responce) {
        self.faceImg.image = image;
        NSString *path = [[[responce objectForKey:@"info"] objectForKey:@"sacUser"] objectForKey:@"photo"];
        NSString *url = [NSString stringWithFormat:@"%@/%@",Prefix, path];
        //处理一下缓存
        [[SDWebImageManager sharedManager] saveImageToCache:image forURL: [NSURL URLWithString:url]];
        [[Configuration Instance] setAvatar:url];
    } failure:^(NSError *error) {
        ;
    }];
}

- (void)requestPostUrlWithImage: (NSString *)serviceName parameters:(NSDictionary *)dictParams image:(UIImage *)image success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure {
    
    NSString *strService = [NSString stringWithFormat:@"%@%@",BASEURL,serviceName];
    [SVProgressHUD show];
    
    NSData *fileData = image?UIImageJPEGRepresentation(image, 0.5):nil;
    
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strService parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:@"uploadFile"
                                    fileName:@"face.jpg"
                                    mimeType:@"image/jpeg"];
        }
    } error:&error];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"Wrote %f", uploadProgress.fractionCompleted);
    }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          [SVProgressHUD dismiss];
                                          if (error)
                                          {
                                              failure(error);
                                          }
                                          else
                                          {
                                              NSLog(@"POST Response  : %@",responseObject);
                                              success(responseObject);
                                              
                                          }
                                      }];
    
    [uploadTask resume];
    
}


@end
