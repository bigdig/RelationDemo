//
//  RegisterViewModel.m
//  DressingCollection
//
//  Created by renxingguo on 16/4/20.
//  Copyright © 2016年 北京伊人依美科技有限公司. All rights reserved.
//

#import "RegisterViewModel.h"
#import "NSString+MD5.h"
#import "JSONHTTPClient.h"
#import "BloomFilter.h"

@interface WtRegisterModel : JSONModel
/**
 {"code":1,"message":"success","info":{"user_id":88763,"user_name":"袁东华","mobile_phone":"18801123830","avatar":"/data/avatar/2015/09/02/14/88763/.png","recode":"4","redesc":"成功!"}
 */
@property (nonatomic,strong) NSString<Optional> *user_id;
@property (nonatomic,strong) NSString<Optional> *user_name;
@property (nonatomic,strong) NSString<Optional> *mobile_phone;
@property (nonatomic,strong) NSString<Optional> *avatar;
@property (nonatomic,strong) NSString<Optional> *employer_id;
@property (nonatomic,strong) NSString<Optional> *vip;

@property (nonatomic,strong) NSString<Optional> *school;
@property (nonatomic,strong) NSString<Optional> *grade;
@property (nonatomic,strong) NSString<Optional> *specialty;
@property (nonatomic,strong) NSString<Optional> *train;
@property (nonatomic,strong) NSString<Optional> *award;

@property (nonatomic,strong) NSString<Optional> *email;
@property (nonatomic,strong) NSString<Optional> *qq;

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation WtRegisterModel

- (BOOL)isSuccess
{
    return self.code == 1;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"code": @"code",
                                                       @"message":@"message",
                                                       @"info.sacUser.id":@"user_id",
                                                       @"info.sacUser.logname":@"user_name",
                                                       @"info.sacUser.mobile":@"mobile_phone",
                                                       
                                                       @"info.sacUser.school":@"school",
                                                       @"info.sacUser.grade":@"grade",
                                                       @"info.sacUser.specialty":@"specialty",
                                                       @"info.sacUser.train":@"train",
                                                       @"info.sacUser.award":@"award",
                                                       
                                                       @"info.sacUser.email":@"email",
                                                       @"info.sacUser.qq":@"qq"
                                                       
                                                       }];
}

@end


@implementation RegisterViewModel


- (instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

// 初始化绑定
- (void)initialBind
{
    // 监听账号的属性值改变，把他们聚合成一个信号。
    _enableRegisterSignal = [RACSignal combineLatest:@[RACObserve(self, mobile),RACObserve(self, password),RACObserve(self, verifyCode),RACObserve(self, invitationCode)] reduce:^id(NSString *account,NSString *pwd){
        return @( [NSString isMobileNumber:[_mobile substringToIndex:MIN(_mobile.length, MAX_PHONENUM_LEN) ]] && (_password.length>=MIN_PASSWORD_LEN) );
    }];
    
    // 处理登录业务逻辑
    _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    //验证码错误识别
                    NSString *verifycode = [NSString stringWithFormat:@"%@%@", _mobile, _verifyCode ];
                    if (![[BloomFilter Instance] lookup: verifycode ])
                    {
                        //验证码错误
                        [subscriber sendNext:RACTuplePack(@(NO),@"验证码校验出错，请输入正确的验证码！")];
                        [subscriber sendCompleted];
                        return nil;
                    }
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    NSString *devicetoken = [userDefaults objectForKey:@"DeviceTokenStringKEY"];
                    
                    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                    
                    NSDictionary* para= @{@"device_code":devicetoken,
                                          @"device_name":[[UIDevice currentDevice] model],
                                          @"mobile":self.mobile,
                                          @"pwd": [self.password MD5Hash],
                                          @"appver": [NSString stringWithFormat:@"I_%@",version],
                                          @"channel":@"IOS"
                                          };
                    
                    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/userRegWt.json",BASEURL]
                                                       params:para
                                                   completion:^(id json, JSONModelError *err) {
                                                       
                                                       //check err, process json ...
                                                       WtRegisterModel *model = [[WtRegisterModel alloc] initWithDictionary:json error:nil];
                                                       
                                                       if (!model.isSuccess)
                                                       {
                                                           [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                       }
                                                       else
                                                       {
                                                           [[NSUserDefaults standardUserDefaults]setValue:model.user_id forKey:@"user_id" ];
                                                           [[NSUserDefaults standardUserDefaults]synchronize];
                                                           
                                                           [[Configuration Instance]saveUserID:model.user_id  andUserName:model.user_name andUserRank:Nil andRankName:Nil andRankImg:Nil andPhone:model.mobile_phone];
                                                           [[Configuration Instance] setPassword: [para valueForKey:@"password"]];
                                                           [[Configuration Instance] setAvatar: [[NSString stringWithFormat:@"%@/%@",Prefix,model.avatar] URLEncodedStringFix]];
                                                           [Configuration Instance].employer_id = model.employer_id;
                                                           [Configuration Instance].vip = model.vip;
                                                           
                                                           [Configuration Instance].school = model.school;
                                                           [Configuration Instance].grade = model.grade;
                                                           [Configuration Instance].specialty = model.specialty;
                                                           [Configuration Instance].train = model.train;
                                                           [Configuration Instance].award = model.award;
                                                           [Configuration Instance].email = model.email;
                                                           [Configuration Instance].qq = model.qq;
                                                           
                                                           [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                                           
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
                                                           
                                                       }
                                                       [subscriber sendCompleted];
                                                   }];
                    
                    return nil;
                }];
    }];
}

@end
