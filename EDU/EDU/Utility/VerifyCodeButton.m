//
//  VerifyCodeButton.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/25.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "VerifyCodeButton.h"
#import "BloomFilter.h"
#import "Configuration.h"
#import "ReactiveCocoa.h"
#import "NSString+Mobile.h"
#import "JSONHttpClient.h"

@interface SecCodeSendModel : NSObject

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;
@end

@implementation SecCodeSendModel
@end

@interface VerifyCodeButton ()
{
    int seconds;
    NSTimer *timer;
    NSString *verifyCode;
}

@end

@implementation VerifyCodeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            [self requestVerifyCode:[Configuration Instance].phoneNumber];
            return [RACSignal empty];
        }];
    }
    return self;
}



-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('0' + arc4random_uniform(9))];
    }
    return string;
}

- (void)requestVerifyCode:(NSString*)phoneNumber
{
    //check is correct phone number
    if (![NSString isMobileNumber: phoneNumber ]) {
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                      message:NSLocalizedString(@"errorphonenumber", nil)
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;;
    }
    
    seconds = 60;
    [self releaseTImer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    {
        verifyCode = [self generateRandomString:4];
        
        //tag verify code
        [[BloomFilter Instance] addToSet: [NSString stringWithFormat:@"%@%@",  phoneNumber, verifyCode]];
        
        //两个都加
        [[BloomFilter Instance] addToSet: verifyCode];


        NSDictionary* para= @{@"phone":phoneNumber,
                              @"code":verifyCode
                              };
        
        [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/secCodeSendFamily.json",BASEURL]
                                           params:para
                                       completion:^(id json, JSONModelError *err) {
                                       }];
        
    }
    
}

- (void)beginTime
{
    seconds = 60;
    [self releaseTImer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}


#pragma mark
#pragma mark -verifycode

//倒计时方法验证码实现倒计时60秒，60秒后按钮变换开始的样子
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        [self setTitle:@"获取验证码" forState: UIControlStateNormal];
        [self  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self  setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"重新获取%d",seconds];
        [self  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self  setEnabled:NO];
        [self  setTitle:title forState:UIControlStateNormal];
    }
}
//如果登陆成功，停止验证码的倒数，
- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 60;
            }
        }
    }
}

@end
