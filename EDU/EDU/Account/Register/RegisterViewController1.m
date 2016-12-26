//
//  RegisterViewController1.m
//  EDU
//
//  Created by renxingguo on 2016/10/17.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "RegisterViewController1.h"
#import "BloomFilter.h"

@interface RegisterViewController1 ()

@end

@implementation RegisterViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *bdview = [self.view viewWithTag:200];
    [bdview setBackgroundColor:[UIColor whiteColor]];
    bdview.layer.cornerRadius = 7.0f;
    bdview.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    bdview.layer.borderWidth = 1;
    bdview.layer.masksToBounds = YES;
    
    
    //长度限制
    [self.textField.rac_textSignal subscribeNext:^(NSString* x) {
        if (x.length>MAX_PHONENUM_LEN) {
            self.textField.text = [x substringToIndex:MAX_PHONENUM_LEN];
        }
        if ([NSString isMobileNumber:self.textField.text]) {
            [Configuration Instance].phoneNumber = self.textField.text;
        }
    }];
    
    
    RACSignal *enabled = [RACSignal combineLatest:@[self.textField.rac_textSignal] reduce:^(NSString *text){
        return @(text &&[text length]==11 && [NSString isMobileNumber:text]);
    }];
    
    @weakify(self);
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id x) {
        //
        @strongify(self);
        NSString* verifyCode = [self generateRandomString:4];
        
        //tag verify code
        [[BloomFilter Instance] addToSet: [NSString stringWithFormat:@"%@%@",  [Configuration Instance].phoneNumber, verifyCode]];
        
        //两个都加
        [[BloomFilter Instance] addToSet: verifyCode];
        
        NSDictionary* para= @{@"phone":[Configuration Instance].phoneNumber,
                              @"code":verifyCode
                              };
        [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/secCodeSend.json",BASEURL]
                                           params:para
                                       completion:^(id json, JSONModelError *err) {
                                       }];
        
        return [RACSignal empty];

    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
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

-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('0' + arc4random_uniform(9))];
    }
    return string;
}




@end
