//
//  EditPasswordViewController.m
//  DressingCollection
//
//  Created by fan junChao on 13-5-15.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "LoginViewController.h"
#import "BloomFilter.h"
#import "NSString+MD5.h"
#import "JSONHttpClient.h"

@interface PwdResetWtModel : JSONModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation PwdResetWtModel

- (BOOL)isSuccess
{
    return self.code == 1;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"code": @"code",
                                                       @"message":@"message"
                                                       
                                                       }];
}

@end

@interface EditPasswordViewController () <UITextFieldDelegate>

@end

@implementation EditPasswordViewController


#pragma mark - initialization and memory manage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
         XLOG(@"==========修改密码==========");
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.edgesForExtendedLayout =UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn:)];
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{
                                                                        //NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:26.0],
                                                                        NSForegroundColorAttributeName: COLOR_LITLE_GREE
                                                                        } forState:UIControlStateNormal];
    }
    
    // Do any additional setup after loading the view from its nib.
    [self.firtPasswordTextField setDelegate:self];
    self.validCodeBtn.enabled = FALSE;
    
    RACSignal* enabled = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal] reduce:^(NSString *text){
        return @(text &&[text length]==11 && [NSString isMobileNumber:text]);
    }];
    
    self.validCodeBtn.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        //
        [self.validCodeBtn requestVerifyCode:self.phoneTextField.text];
        return [RACSignal empty];
    }];
    
    self.commitButton.enabled = FALSE;
    
    RAC(self.commitButton, enabled) = [RACSignal combineLatest:@[self.firtPasswordTextField.rac_textSignal] reduce:^id{
        NSString * regex2 = @"(^[A-Za-z0-9]{6,16}$)";
        NSPredicate * pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
        
        return @([pred2 evaluateWithObject:self.firtPasswordTextField.text]);
    }];
    
    /*
    [self.sendSMSButton addTarget:self action:@selector(sendSMSButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    ActivityConfigData *data = [[[CLogicHandler shareHandler]activeConfogCommand]getDataFromDataBase];
    self.messageNumber = data.message_number;
    NSLog(@"messagenumber:%@",self.messageNumber);
    
    self.sendsmstoLabel.text = [NSString stringWithFormat:@"发送短信至：%@",self.messageNumber];
     */
    
    //长度限制
    [self.phoneTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PHONENUM_LEN) {
            self.phoneTextField.text = [x substringToIndex:MAX_PHONENUM_LEN];
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
    
    [self.firtPasswordTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PASSWORD_LEN) {
            self.firtPasswordTextField.text = [x substringToIndex:MAX_PASSWORD_LEN];
        }
    }];
    
    [self.phoneTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.phoneTextField becomeFirstResponder];
}


- (void)viewDidUnload
{
//    [self setSendSMSButton:nil];
    [self setScrollview:nil];
    [self setFirtPasswordTextField:nil];
//    [self setSendsmstoLabel:nil];
    [super viewDidUnload];
}

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



- (IBAction)changePassword:(id)sender
{
    if ([self.verifyCodeTextField.text length] != 4) {
        //验证码错误
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入正确的验证码！" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    
    
    if (
        [[BloomFilter Instance] lookup:self.verifyCodeTextField.text ]
        )
    {
        
        //设置密码
        
        NSDictionary* para= @{
                              @"mobile":self.phoneTextField.text,
                              @"new_pwd": [self.firtPasswordTextField.text MD5Hash]
                              };
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/pwdResetWt.json",BASEURL]
                                           params:para
                                       completion:^(id json, JSONModelError *err) {
                                           
                                           PwdResetWtModel *model = [[PwdResetWtModel alloc] initWithDictionary:json error:nil];
                                           //check err, process json ...
                                           if (model.code != 1)
                                           {
                                               UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                               [alter show];
                                           }
                                           else
                                           {
                                               [[Configuration Instance] setPassword: [para valueForKey:@"password"]];
                                               [self BackBtn:nil];
                                               
                                           }
                                       }];
    }
    else
    {
        //验证码错误
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"验证码校验出错，请输入正确的验证码！" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alterView show];
    }

}

#pragma mark
#pragma mark - Actions


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollview adjustOffsetToIdealIfNeeded];
}

@end
