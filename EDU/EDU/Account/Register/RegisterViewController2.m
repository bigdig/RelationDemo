//
//  RegisterViewController2.m
//  EDU
//
//  Created by renxingguo on 2016/10/17.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RegisterViewController2.h"
#import "BloomFilter.h"

@interface RegisterViewController2 ()

@end

@implementation RegisterViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.verifyCodeTextField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>4) {
            self.verifyCodeTextField.text = [x substringToIndex:4];
        }
        if ([[BloomFilter Instance] lookup:self.verifyCodeTextField.text ]) {
        }
        else
        {
        }
    }];
    
    RACSignal *enabled = [RACSignal combineLatest:@[self.verifyCodeTextField.rac_textSignal] reduce:^(NSString *x){
        if (x.length==4) {
            if ([[BloomFilter Instance] lookup:self.verifyCodeTextField.text ]) {
                [Configuration Instance].verifyCode = self.verifyCodeTextField.text;
                return @true;
            }
        }
        return @false;
    }];
    
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id x) {
        //
        return [RACSignal empty];
        
    }];
    
    [self.verifyCodeButton beginTime];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.verifyCodeTextField becomeFirstResponder];
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
