//
//  EditPasswordViewControllerV2.m
//  EDU
//
//  Created by renxingguo on 2016/12/6.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "EditPasswordViewControllerV2.h"
#import "LoginViewController.h"
#import "BloomFilter.h"
#import "NSString+MD5.h"
#import "JSONHttpClient.h"
#import "LoginViewModel.h"
#import "Toast.h"
#import "UITextField+PaddingText.h"

@interface PwdResetWtModel1 : JSONModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation PwdResetWtModel1

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

@interface EditPasswordViewControllerV2 () <UITextFieldDelegate>

@end

@implementation EditPasswordViewControllerV2


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
    [self.firtPasswordTextField setLeftPadding:20];
    
    
    [self.firtPasswordTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PASSWORD_LEN) {
            self.firtPasswordTextField.text = [x substringToIndex:MAX_PASSWORD_LEN];
        }
    }];
    
    RACSignal *enable = [RACSignal combineLatest:@[self.firtPasswordTextField.rac_textSignal] reduce:^id{
        /**
        NSString * regex2 = @"(^[A-Za-z0-9]{6,16}$)";
        NSPredicate * pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
        return @([pred2 evaluateWithObject:self.firtPasswordTextField.text]);
         */
        if ([self.firtPasswordTextField.text length]>=MIN_PASSWORD_LEN) {
            return @(true);
        }
        return @(false);
    }];
    self.commitButton.rac_command = [[RACCommand alloc] initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        
        NSDictionary* para= @{
                              @"mobile":[Configuration Instance].phoneNumber,
                              @"new_pwd": [self.firtPasswordTextField.text MD5Hash]
                              };
        
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/pwdResetWt.json",BASEURL]
                                           params:para
                                       completion:^(id json, JSONModelError *err) {
                                           
                                           
                                           PwdResetWtModel1 *model = [[PwdResetWtModel1 alloc] initWithDictionary:json error:nil];
                                           //check err, process json ...
                                           if (model.code != 1)
                                           {
                                               UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                               [alter show];
                                           }
                                           else
                                           {
                                               [[Configuration Instance] setPassword: [para valueForKey:@"password"]];
                                               //login
                                               LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
                                               loginViewModel.account = [Configuration Instance].phoneNumber;
                                               loginViewModel.password = self.firtPasswordTextField.text;
                                               
                                               [loginViewModel.LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
                                                   RACTupleUnpack(id success, NSString *info) = x;
                                                   
                                                   if ([success boolValue]) {
                                                       //login success
                                                       [[[Toast alloc] initWithMessage:info] show];
                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
                                                   }
                                                   else
                                                   {
                                                       [[[Toast alloc] initWithMessage:info] show];
                                                   }
                                               }];
                                               [loginViewModel.LoginCommand execute:nil];
                                           }
                                       }];
        return [RACSignal empty];

    }];
    
    
    [self.firtPasswordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
