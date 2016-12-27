//
//  FMProfileTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/21.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMProfileTableViewController.h"
#import "FMProfileViewModel.h"
#import "Toast.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Orientation.h"
#import "UIImage+UIImageScale.h"

#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
#import "UIButton+SetCropImage.h"
#import "FMWtFaUserLoginModel.h"

@interface FMProfileTableViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,STPickerAreaDelegate, STPickerSingleDelegate, STPickerDateDelegate>

@property (nonatomic,strong) FMProfileViewModel *profileViewModel;

@end

@implementation FMProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.birthdayTextField.delegate = self;
    self.sexTextField.delegate = self;
    
    UIImageView *imageView = self.faceImageView;
    [imageView setImage:[UIImage imageNamed:@"头像"]];
    imageView.layer.cornerRadius = 5;
    imageView.clipsToBounds = YES;
    
    {
        self.faceImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImgClicked:)];
        [singleTap setNumberOfTouchesRequired:1];
        [singleTap setNumberOfTapsRequired:1];
        [self.faceImageView addGestureRecognizer:singleTap];
    }
    
    [RACObserve([Configuration Instance], avatar) subscribeNext:^(NSString* x) {
        NSLog(@"%@",x);
        [_faceImageView sd_setImageWithURL:[NSURL URLWithString: x ]
                    placeholderImage:[UIImage imageNamed:@"头像"]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           }];
        
    }];
    
    [RACObserve([Configuration Instance],wxopenid) subscribeNext:^(id x) {
        if ([Configuration Instance].wxopenid && [[Configuration Instance].wxopenid length]) {
            
            [self getUserInfo:[Configuration Instance].wxopenid access_token:[Configuration Instance].wxaccess_token];
        }
    }];
    

    self.profileViewModel = [[FMProfileViewModel alloc] init];
    [self bindModel];
    
    [self.profileViewModel.saveProfileCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 视图模型绑定
- (void)bindModel
{
    @weakify(self);
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    
    self.phoneTextField.text = [Configuration Instance].phoneNumber;
    self.nameTextField.text = [Configuration Instance].userName;
    self.birthdayTextField.text = [Configuration Instance].birthday;
    self.sexTextField.text = [Configuration Instance].sex==0?@"女":@"男";
    
    self.phoneTextField.enabled = FALSE;
    RAC(self.profileViewModel, name) = self.nameTextField.rac_textSignal;
    RAC(self.profileViewModel, sex) = self.sexTextField.rac_textSignal;
    RAC(self.profileViewModel, birthday) = self.birthdayTextField.rac_textSignal;
    
    self.nextButton.rac_command = [[RACCommand alloc] initWithEnabled:self.profileViewModel.enableSignal signalBlock:^RACSignal *(id input) {
        //
        @strongify(self);
        [self.profileViewModel.saveProfileCommand execute:nil];
        return [RACSignal empty];
    }];
    
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[RACScheduler mainThreadScheduler] schedule:^{
        [self.nameTextField sendActionsForControlEvents:UIControlEventAllEvents];
        [self.view endEditing:TRUE];
        
        
        if (textField == self.birthdayTextField) {
            [self.birthdayTextField resignFirstResponder];
            STPickerDate *pickerDate = [[STPickerDate alloc]init];
            [pickerDate setDelegate:self];
            [pickerDate show];
        }
        
        
        if (textField == self.sexTextField) {
            [self.sexTextField resignFirstResponder];
            
            NSMutableArray *arrayData = [NSMutableArray array];
            [arrayData addObject:@"男"];
            [arrayData addObject:@"女"];
            
            STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
            [pickerSingle setArrayData:arrayData];
            [pickerSingle setTitle:@"请选择性别"];
            [pickerSingle setTitleUnit:@"性"];
            //[pickerSingle setContentMode:STPickerContentModeCenter];
            [pickerSingle setDelegate:self];
            [pickerSingle show];
        }

    }];
    
    
    
}

/**
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}
 */

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@", selectedTitle];
    self.sexTextField.text = text;
    [self.sexTextField sendActionsForControlEvents:(UIControlEventAllEvents)];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd-%zd-%zd", year, month, day];
    self.birthdayTextField.text = text;
    [self.birthdayTextField sendActionsForControlEvents:(UIControlEventAllEvents)];
}


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
    image = [[image fixOrientation] getSubImageFitToWH:self.faceImageView.frame.size.width Height:self.faceImageView.frame.size.height];
    
    [self.faceImageView setImage:image];
    self.profileViewModel.faceImage = image;
}


// 获取用户信息
- (void)getUserInfo:(NSString*)openid access_token:(NSString*) access_token {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token, openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"openid = %@", [dic objectForKey:@"openid"]);
                NSLog(@"nickname = %@", [dic objectForKey:@"nickname"]);
                NSLog(@"sex = %@", [dic objectForKey:@"sex"]);
                NSLog(@"country = %@", [dic objectForKey:@"country"]);
                NSLog(@"province = %@", [dic objectForKey:@"province"]);
                NSLog(@"city = %@", [dic objectForKey:@"city"]);
                NSLog(@"headimgurl = %@", [dic objectForKey:@"headimgurl"]);
                NSLog(@"unionid = %@", [dic objectForKey:@"unionid"]);
                NSLog(@"privilege = %@", [dic objectForKey:@"privilege"]);
                
                [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]];
                self.nameTextField.text = [dic objectForKey:@"nickname"];
                self.sexTextField.text = [[dic objectForKey:@"sex"] integerValue]==0?@"女":@"男";
                
                [self.nameTextField sendActionsForControlEvents:(UIControlEventAllEvents)];
                [self.sexTextField sendActionsForControlEvents:(UIControlEventAllEvents)];
                self.profileViewModel.faceImage = self.faceImageView.image;
                
            }
        });
    });
}

@end
