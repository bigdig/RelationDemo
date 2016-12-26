//
//  FMAddRelationTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMAddRelationTableViewController.h"
#import "FMFamilyProfileViewModel.h"
#import "Toast.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Orientation.h"
#import "UIImage+UIImageScale.h"

#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"

@interface FMAddRelationTableViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,STPickerAreaDelegate, STPickerSingleDelegate, STPickerDateDelegate>

@property (nonatomic,strong) FMFamilyProfileViewModel *profileViewModel;

@end

@implementation FMAddRelationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.birthdayTextField.delegate = self;
    self.sexTextField.delegate = self;
    self.relativeTextField.delegate = self;
    
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
    
    
    self.profileViewModel = [[FMFamilyProfileViewModel alloc] init];
    [self bindModel];
    
    [self.profileViewModel.saveProfileCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            //show ralation
            UIViewController * ctl = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"FMRelationViewController"];
            [self.navigationController pushViewController:ctl animated:YES];
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
    
    [RACObserve([Configuration Instance], tagName) subscribeNext:^(id x) {
        
        self.relativeTextField.text = [Configuration Instance].tagID;
        [self.relativeTextField sendActionsForControlEvents:UIControlEventAllEvents];
        
    }];
    
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
    
    RAC(self.profileViewModel, mobile) = self.phoneTextField.rac_textSignal;
    RAC(self.profileViewModel, name) = self.nameTextField.rac_textSignal;
    RAC(self.profileViewModel, sex) = self.sexTextField.rac_textSignal;
    RAC(self.profileViewModel, birthday) = self.birthdayTextField.rac_textSignal;
    RAC(self.profileViewModel, code) = self.relativeTextField.rac_textSignal;
    RAC(self.profileViewModel, named) = self.relativeTextField.rac_textSignal;
    
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.relativeTextField) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FMCodeTableViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        return FALSE;
    }
    return TRUE;
}

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
    NSString *text = [NSString stringWithFormat:@"%4zd-%2zd-%2zd", year, month, day];
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

@end
