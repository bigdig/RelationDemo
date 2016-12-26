//
//  MyAccountViewController.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/7.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "MyAccountViewController.h"

#import "MBSetupPageSection.h"
#import "MBSectionHeader.h"
#import "MBSectionFooter.h"
#import "MBTextFieldItem.h"
#import "MBSwitchItem.h"
#import "MBLabelItem.h"

#import "EditPasswordViewController.h"
#import "JSONHTTPClient.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Orientation.h"
#import "UIImage+UIImageScale.h"

@import AFNetworking;
@import SVProgressHUD;

@interface MyAccountViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MyAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"设置"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.hidesNextButton = TRUE;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [imageView setImage:[UIImage imageNamed:@"头像"]];
    imageView.layer.cornerRadius = 22;
    imageView.clipsToBounds = YES;
    self.faceImg = imageView;
    
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
                    placeholderImage:[UIImage imageNamed:@"头像"]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           }];
        
    }];
    
    __weak MyAccountViewController *weakSelf = self;
    
    //Configure section
    MBSetupPageSection *section = [MBSetupPageSection sectionWithTitle:nil];
    section.headerViewBlock = ^UIView*(MBSetupPageSection *section) {
        return [weakSelf preparedPageHeaderViewWithTitle:section.title];
    };
    
    section.headerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };
    
    section.footerViewBlock = ^UIView*(MBSetupPageSection *section) {
        //        MBSectionFooter *footer = [weakSelf preparedFooterViewWithImage:[UIImage imageNamed:@"SampleImage"]
        //                                                                  title:@"Sign in with your account credentials"
        //                                                               subtitle:@"Your credentials should have been sent to you by administrator. Contact our support team if you have any questions."];
        //        [footer.topButton setTitle:@"Skip This Step" forState:UIControlStateNormal];
        //        [footer.topButton addTarget:weakSelf action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        //        return footer;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return view;
    };
    section.footerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        return 0.1;
    };
    
    
    
    MBTextFieldItem *username = [[MBTextFieldItem alloc] initWithTitle:@"昵称" text: [[Configuration Instance] userName] placeholder:@"昵称"];
    username.keyboardType = UIKeyboardTypeURL;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.textDidChangeBlock = ^(MBTextFieldItem *item) {
        [weakSelf validate];
        
        if([item text].length > 8)
        {
            item.text = [item.text substringToIndex:8];
        }
    };
    username.validateBlock = ^BOOL(MBSetupPageItem *item) {
        return [(MBTextFieldItem *)item text].length > 0;
    };
    username.textDidEndEditingBlock = ^(MBTextFieldItem *item){
        
        //没有变化，则返回
        if ([item.text compare:[[Configuration Instance] userName]] == NSOrderedSame) {
            return;
        }
        if ([item.text length]==0) {
            return;
        }
        
        NSDictionary* para= @{@"user_id":[Configuration Instance].userID,
                              @"logname":item.text
                              };
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/sacUserInfoUpdWt.json",BASEURL]
                                           params:para
                                       completion:^(id json, JSONModelError *err) {
                                           
                                           //check err, process json ...
                                           [[Configuration Instance] setUserName:item.text];
                                       }];
        
    };
    
    
    MBTextFieldItem *phone = [[MBTextFieldItem alloc] initWithTitle:@"手机号" text:[[Configuration Instance] phoneNumber] placeholder:@"186888888"];
    __weak MBTextFieldItem *weak_phone = phone;
    phone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phone.autocorrectionType = UITextAutocorrectionTypeNo;
    phone.autocapitalizationType = UITextAutocapitalizationTypeNone;
    phone.clearButtonMode = UITextFieldViewModeNever;
//    phone.textDidChangeBlock = ^(MBTextFieldItem *item) {
//        [weakSelf validate];
//        if([item text].length > MAX_PHONENUM_LEN)
//        {
//            item.text = [item.text substringToIndex:MAX_PHONENUM_LEN];
//        }
//        weak_phone.text = [[Configuration Instance] phoneNumber];
//    };
    phone.validateBlock = ^BOOL(MBSetupPageItem *item) {
        return [(MBTextFieldItem *)item text].length > 0;
    };
    
    //    MBTextFieldItem *passwordItem = [[MBTextFieldItem alloc] initWithTitle:@"Password" text:nil placeholder:@"Required"];
    //    passwordItem.autocorrectionType = UITextAutocorrectionTypeNo;
    //    passwordItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //    passwordItem.secureTextEntry = YES;
    //    passwordItem.textDidChangeBlock = ^(MBTextFieldItem *item) {
    //        [weakSelf validate];
    //    };
    //    passwordItem.validateBlock = ^BOOL(MBSetupPageItem *item) {
    //        return [(MBTextFieldItem *)item text].length > 0;
    //    };
    
    //    MBSwitchItem *connectionTypeItem = [[MBSwitchItem alloc] initWithTitle:@"Use SSL" value:YES];
    //    connectionTypeItem.switchAlignment = MBSwitchAlignmentLeft;
    
    MBLabelItem *imageItem = [[MBLabelItem alloc] initWithTitle:@"头象" detail:nil style:UITableViewCellStyleSubtitle];
    imageItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    imageItem.didSelectBlock = ^(MBSetupPageItem *item) {
        [item deselectAnimated:YES];
    };
    
    
    section.items = @[imageItem,username,phone];
    
    MBSetupPageSection *section2 = [self sectionTwo];
    self.sections = @[section,section2];
}

- (BOOL)validate
{
    BOOL success = [super validate];
    self.nextButtonItem.enabled = success;
    
    return success;
}

- (MBSetupPageSection*)sectionTwo
{
    
    //Backup section
    MBSetupPageSection *section2 = [MBSetupPageSection sectionWithTitle:nil];
    
    section2.headerViewBlock = ^UIView *(MBSetupPageSection *section) {
        //        MBLabel *label = [[MBLabel alloc] init];
        //        label.insets = UIEdgeInsetsMake(0, 10.0, 0, 0);
        //        label.text = [section.title uppercaseString];
        //        return label;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return view;
    };
    
    section2.headerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        return 8;
    };
    __weak MyAccountViewController *weakSelf = self;
    section2.footerViewBlock = ^UIView*(MBSetupPageSection *section) {
        MBSectionFooter *footer = [weakSelf preparedFooterViewWithImage:nil
                                                                  title:nil
                                                               subtitle:nil];
        
        footer.topButton.backgroundColor = COLOR_LITLE_BLUE;
        footer.topButton.layer.cornerRadius = 3.0;
        [footer.topButton setTitle:@"             注      销             " forState:UIControlStateNormal];
        [footer.topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        
//        [footer.topButton setBackgroundImage:[UIImage imageNamed:@"1121"] forState:UIControlStateNormal];
        [footer.topButton addTarget:weakSelf action:@selector(checkout) forControlEvents:UIControlEventTouchUpInside];
        
        return footer;
    };
    
    
    section2.footerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };
    
    MBLabelItem *backupItem2 = [[MBLabelItem alloc] initWithTitle:@"修改密码" detail:nil style:UITableViewCellStyleSubtitle];
    backupItem2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    backupItem2.didSelectBlock = ^(MBSetupPageItem *item) {
        [self editPassword:nil];
        [item deselectAnimated:YES];
    };
    
    MBLabelItem *backupItem3 = [[MBLabelItem alloc] initWithTitle:@"个人资料" detail:nil style:UITableViewCellStyleSubtitle];
    backupItem3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    backupItem3.didSelectBlock = ^(MBSetupPageItem *item) {
        [self editInfo];
        [item deselectAnimated:YES];
    };
    
    section2.items = @[backupItem2,backupItem3];
    return section2;
}

-(void)editInfo{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"V2LoginStoryboard" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)checkout
{
    [[Configuration Instance] checkout];
    if ([self.navigationController.viewControllers count]>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }
}

- (IBAction)editPassword:(id)sender
{
//    EditPasswordViewController *newPasswordVC = [[EditPasswordViewController alloc]initWithNibName:@"EditPasswordViewController" bundle:nil];
//    newPasswordVC.title = @"修改密码";
//    [self.navigationController pushViewController:newPasswordVC animated:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"V2LoginStoryboard" bundle:nil];
    UIViewController *newPasswordVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"EditPasswordViewController"];
    [self.navigationController pushViewController:newPasswordVC animated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0&& indexPath.row==0) {
    
        cell.accessoryView = self.faceImg;
        [cell layoutSubviews];

    }
    return cell;
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
