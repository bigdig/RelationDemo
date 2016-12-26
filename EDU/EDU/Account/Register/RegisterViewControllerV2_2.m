//
//  RegisterViewControllerV2_2.m
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RegisterViewControllerV2_2.h"
#import "ProfileViewModel.h"
#import "RegisterViewModel.h"
#import "Toast.h"
#import "EDUBaiduSchoolDataModels.h"
#import "UITextField+PaddingText.h"

@interface RegisterViewControllerV2_2 ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) RegisterViewModel *registerViewModel;
@property (nonatomic,strong) ProfileViewModel *profileViewModel;
@property (nonatomic,strong) EDUBaiduSchoolResults *school;
@property (nonatomic,strong) UIPickerView *picker;
@property (strong,nonatomic) NSArray *pickerValues;

@end

@implementation RegisterViewControllerV2_2

#pragma mark - initialization and memory manage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.schoolTextField.delegate = self ;
    //[self.schoolTextField becomeFirstResponder];
    
    self.profileViewModel = [[ProfileViewModel alloc] init];
    self.registerViewModel = [[RegisterViewModel alloc] init];
    [self bindModel];
    
    [self.profileViewModel.saveProfileCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            //login success
            [self BackBtn:nil];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
        }
    }];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn:)];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"BAIDU_SCHOOL_SELECT" object:nil] subscribeNext:^(NSNotification *x) {
        EDUBaiduSchoolResults *item = x.object;
        self.school = item;
        self.schoolTextField.text = item.name;
        
        self.profileViewModel.school = item.name;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"SCHOOL_SELECT" object:nil] subscribeNext:^(NSNotification *x) {
        NSString *item = x.object;
        self.school = nil;
        self.schoolTextField.text = item;
        self.profileViewModel.school = item;
    }];
    
    
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.picker.showsSelectionIndicator = YES;
    self.gradeTextField.inputView = self.picker;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.pickerValues = [self geneRangArrayFrom:1 To:10 Unit:@"年级"];
    

    NSArray * textFields = @[self.passwordTextField, self.gradeTextField, self.schoolTextField];
    [textFields enumerateObjectsUsingBlock:^(UITextField*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
        obj.layer.borderWidth = 1.0;
        obj.layer.masksToBounds = YES;
        
        [obj setLeftPadding:20];
    }];
    
    {
        [self.hyperLabel setLinkForSubstring:@"美育星光服务条款" withLinkHandler:^(FRHyperLabel *label, NSString *substring){
            //            [[UIApplication sharedApplication] openURL:aURL];
            UIViewController * vc = [[QQPlayViewController alloc] init];
            [Configuration Instance].current_video_url_title = @"服务条款";
            [Configuration Instance].current_video_url = @"http://dt.xingguangedu.com/clause/clause.html";
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
}

// 视图模型绑定
- (void)bindModel
{
    @weakify(self);
    // 给模型的属性绑定信号

    self.registerViewModel.mobile = [Configuration Instance].phoneNumber;
    self.registerViewModel.verifyCode = [Configuration Instance].verifyCode;
    self.registerViewModel.name = [Configuration Instance].phoneNumber;
    RAC(self.registerViewModel, password) = self.passwordTextField.rac_textSignal;
    
    self.nextButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        // 执行登录事件
        if ([self.passwordTextField.text length] == 0) {
            [[[Toast alloc] initWithMessage:@"请输入密码!"] show];
            return [RACSignal empty];
        }
        [self.passwordTextField resignFirstResponder];
        
        if ([self.schoolTextField.text length] == 0) {
            [[[Toast alloc] initWithMessage:@"请选择学校!"] show];
            return [RACSignal empty];
        }
        [self.schoolTextField resignFirstResponder];
        
        if ([self.gradeTextField.text length] == 0) {
            [[[Toast alloc] initWithMessage:@"请选择年级!"] show];
            return [RACSignal empty];
        }
        [self.gradeTextField resignFirstResponder];
        [self.registerViewModel.registerCommand execute:nil];
        return [RACSignal empty];
    }];
    
    RAC(self.profileViewModel, school) = _schoolTextField.rac_textSignal;
    RAC(self.profileViewModel, grade) = _gradeTextField.rac_textSignal;
    //    RAC(self.profileViewModel, specialty) = _specialistTextField.rac_textSignal;
    //    RAC(self.profileViewModel, name) = _nicknameTextField.rac_textSignal;
    //    RAC(self.profileViewModel, award) = _certification.rac_textSignal;
    
    [self.registerViewModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        @strongify(self);
        if ([success boolValue]) {
            //login success
            //[self BackBtn:nil];
            
            if(self.school)
            {
                
                NSDictionary* para= @{ @"user_id":  [Configuration Instance].userID,
                                       @"name":self.school.name,
                                       @"lat": [[NSNumber numberWithDouble: self.school.location.lat] stringValue],
                                       @"lng":[[NSNumber numberWithDouble: self.school.location.lng] stringValue],
                                       @"address":self.school.address,
                                       @"street_id":self.school.streetId==nil?@"NULL":self.school.streetId,
                                       @"uid":self.school.uid
                                       };
                
                [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/sacSchoolSaveWt.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                    //
                }];
            }
            [self.profileViewModel.saveProfileCommand execute:nil];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - Actions


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    [self.passwordTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];
    [self.gradeTextField resignFirstResponder];
}

//返回
- (IBAction)BackBtn:(id)sender {
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


#pragma mark
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.schoolTextField) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SchoolSelectViewControllerV2"];
        [self.navigationController pushViewController:vc animated:YES];
        return FALSE;
    }
    return TRUE;
}

// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;  // 返回1表明该控件只包含1列
}
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回books.count，表明books包含多少个元素，该控件就包含多少行
    return self.pickerValues.count;
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回books中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用books中的第几个元素
    return [self.pickerValues objectAtIndex:row];
}
// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    /*
     // 使用一个UIAlertView来显示用户选中的列表项
     UIAlertView* alert = [[UIAlertView alloc]
     initWithTitle:@"提示"
     message:[NSString stringWithFormat:@"你选中的图书是：%@"
     , [books objectAtIndex:row]]
     delegate:nil
     cancelButtonTitle:@"确定"
     otherButtonTitles:nil];
     [alert show];
     */
    self.gradeTextField.text =  [self.pickerValues objectAtIndex:row];
    self.profileViewModel.grade = self.gradeTextField.text;
}

- (NSArray*)geneRangArrayFrom:(int)from To:(int)to Unit:(NSString*)unit
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (int i=from; i<to; i++) {
        [array addObject:[NSString stringWithFormat:@"%d %@",i,unit]];
    }
    return array;
}
@end
