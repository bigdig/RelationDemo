//
//  RegisterViewController3.m
//  EDU
//
//  Created by renxingguo on 2016/10/17.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RegisterViewController3.h"
#import "NSString+MD5.h"
#import "ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "Toast.h"

@interface RegisterViewController3 ()

@property (nonatomic,strong) RegisterViewModel *registerViewModel;

@end

@implementation RegisterViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RACSignal *enabled = [RACSignal combineLatest:@[self.firstTextField.rac_textSignal,self.secondTextField.rac_textSignal] reduce:^(NSString *pwd1,NSString *pwd2){
        return @([pwd1 isEqualToString:pwd2]);
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
    self.registerViewModel.mobile = [Configuration Instance].phoneNumber;
    self.registerViewModel.verifyCode = [Configuration Instance].verifyCode;
    self.registerViewModel.name = [Configuration Instance].phoneNumber;
    RAC(self.registerViewModel, password) = _secondTextField.rac_textSignal;
    
    RACSignal *enabled = [RACSignal combineLatest:@[self.firstTextField.rac_textSignal,self.secondTextField.rac_textSignal] reduce:^(NSString *pwd1,NSString *pwd2){
        return @([pwd1 isEqualToString:pwd2]);
    }];
    
    _button.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        //
        @strongify(self);
        // 执行登录事件
        [self.firstTextField resignFirstResponder];
        [self.secondTextField resignFirstResponder];
        [self.registerViewModel.registerCommand execute:nil];
        return [RACSignal empty];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.firstTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
