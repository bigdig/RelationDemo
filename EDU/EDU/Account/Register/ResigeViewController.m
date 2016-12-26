//
//  ResigeViewController.m
//  DressingCollection
//
//  Created by fan junChao on 13-5-2.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import "ResigeViewController.h"
#import "BloomFilter.h"
#import "NSString+MD5.h"
#import "ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "Toast.h"
//#import "HMScannerController.h"


static inline BOOL IsEmpty(id object) {
    return object == nil
    || object == [NSNull null]
    || ([object respondsToSelector:@selector(length)]
        && [(NSData *) object length] == 0)
    || ([object respondsToSelector:@selector(count)]
        && [(NSArray *) object count] == 0);
}

@interface ResigeViewController () <UITextFieldDelegate>

@property (nonatomic,strong) RegisterViewModel *registerViewModel;

@end

@implementation ResigeViewController

@synthesize phoneNumTextField = _phoneNumTextField;

#pragma mark - initialization and memory manage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
         XLOG(@"==========注册==========");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.phoneNumTextField.delegate = self ;
    [self.phoneNumTextField becomeFirstResponder];
    self.verifyCodeTextField.enabled = TRUE;
    [self.navigationItem setTitle:@"注册"];
    self.verifyCodeTextField.delegate = self;
   
    {
        self.validCodeBtn.enabled = FALSE;
        RACSignal *enabled = [RACSignal combineLatest:@[self.phoneNumTextField.rac_textSignal] reduce:^(NSString *text){
            if (text &&[text length]==11 && [NSString isMobileNumber:text]) {
                [Configuration Instance].phoneNumber = text;
            }
            return @(text &&[text length]==11 && [NSString isMobileNumber:text]);
        }];

        
        self.validCodeBtn.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
            //
            [self.validCodeBtn requestVerifyCode:self.phoneNumTextField.text];
            return [RACSignal empty];
        }];
    }
    
    //长度限制
    [self.phoneNumTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PHONENUM_LEN) {
            self.phoneNumTextField.text = [x substringToIndex:MAX_PHONENUM_LEN];
        }
        if ([NSString isMobileNumber:self.phoneNumTextField.text]) {
            [Configuration Instance].phoneNumber = self.phoneNumTextField.text;
        }
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PASSWORD_LEN) {
            self.passwordTextField.text = [x substringToIndex:MAX_PASSWORD_LEN];
        }
    }];
    
    
    [self.verifyCodeTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>4) {
            self.verifyCodeTextField.text = [x substringToIndex:4];
        }
        if ([[BloomFilter Instance] lookup:self.verifyCodeTextField.text ]) {
            //self.verifyCodeTextField.textColor = [UIColor greenColor];
        }
        else
        {
            self.verifyCodeTextField.textColor = [UIColor blackColor];
        }
    }];
    
    
    self.registerViewModel = [[RegisterViewModel alloc] init];
    [self bindModel];
    
    [self.registerViewModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        RACTupleUnpack(id success, NSString *info) = x;
        
        if ([success boolValue]) {
            //login success
//            [self BackBtn:nil];
        }
        else
        {
            [[[Toast alloc] initWithMessage:info] show];
        }
    }];
}

// 视图模型绑定
- (void)bindModel
{
    @weakify(self);
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.registerViewModel, mobile) = _phoneNumTextField.rac_textSignal;
    RAC(self.registerViewModel, password) = _passwordTextField.rac_textSignal;
    RAC(self.registerViewModel, verifyCode) = _verifyCodeTextField.rac_textSignal;
    RAC(self.registerViewModel, invitationCode) = _invitationTextField.rac_textSignal;
    RAC(self.registerViewModel, name) = _nicknameTextField.rac_textSignal;
    
    _registeButton.rac_command = [[RACCommand alloc] initWithEnabled:self.registerViewModel.enableRegisterSignal signalBlock:^RACSignal *(id input) {
        //
        @strongify(self);
        // 执行登录事件
        [self.passwordTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.verifyCodeTextField resignFirstResponder];
        [self.invitationTextField resignFirstResponder];
        [self.registerViewModel.registerCommand execute:nil];
        return [RACSignal empty];
    }];
    
    self.scanButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        //
        NSString *cardName = @"";
        UIImage *avatar = [UIImage imageNamed:@"avatar"];
        
//        HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
//            
//            self.invitationTextField.text = stringValue;
//            [self.invitationTextField sendActionsForControlEvents:UIControlEventAllEvents];
//        }];
//        
//        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
//        
//        [self showDetailViewController:scanner sender:nil];
        
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setPhoneNumTextField:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
}


#pragma mark - Actions


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    [self.passwordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
    [self.invitationTextField resignFirstResponder];
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

- (IBAction)resetInputText:(id)sender {
    self.phoneNumTextField.text = @"";
    self.passwordTextField.text = @"";
    self.verifyCodeTextField.text = @"";
    self.invitationTextField.text = @"";
}

#pragma mark
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTextField)
    {
        [self.verifyCodeTextField  becomeFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollview adjustOffsetToIdealIfNeeded];
}


@end
