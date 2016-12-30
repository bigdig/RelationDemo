//
//  FMLoginModel.m
//  EDU
//
//  Created by renxingguo on 2016/12/28.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMLoginModel.h"
#import "FMWtFaUserLoginModel.h"



@implementation FMUserLoginModel


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
    
    // 用实体表
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    
                    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{}];
                    
                    if ([Configuration Instance].wxopenid) {
                        [para setObject:[Configuration Instance].wxopenid forKey:@"wxid"];
                    }
                    if ([Configuration Instance].phoneNumber) {
                        [para setObject:[Configuration Instance].phoneNumber forKey:@"mobile"];
                    }
                    
                    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/wtFaUserLogin.json",BASEURL]
                                                       params:para
                                                   completion:^(id json, JSONModelError *err) {
                                                       
                                                       //check err, process json ...
                                                       FMWtFaUserLoginModel *model = [[FMWtFaUserLoginModel alloc] initWithDictionary:json error:nil];
                                                       
                                                       if (!model.isSuccess)
                                                       {
                                                           [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                           [subscriber sendCompleted];
                                                       }
                                                       else
                                                       {
                                                           [[NSUserDefaults standardUserDefaults]setValue:model.user_id forKey:@"user_id" ];
                                                           [[NSUserDefaults standardUserDefaults]synchronize];
                                                           
                                                           [[Configuration Instance]saveUserID:model.user_id  andUserName:model.name andUserRank:Nil andRankName:Nil andRankImg:Nil andPhone:model.mobile];
                                                           [[Configuration Instance] setPassword: [para valueForKey:@"password"]];
                                                           [[Configuration Instance] setAvatar: [[NSString stringWithFormat:@"%@/%@",Prefix,model.avatar] URLEncodedStringFix]];
                                                           
                                                           
                                                           /**
                                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
                                                            */
                                                           //syn
                                                           FMSynUserInfoModel *syn = [[FMSynUserInfoModel alloc] init];
                                                           [[syn.command execute:nil] subscribeNext:^(id x) {
                                                               [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                                               [subscriber sendCompleted];
                                                           }];
                                                       }
                                                       
                                                   }];
                    
                    return nil;
                }];
    }];

}



@end

@implementation FMSynUserInfoModel


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
    
    // 用实体表
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{}];
                    
                    if ([Configuration Instance].userID) {
                        [para setObject:[Configuration Instance].userID forKey:@"user_id"];
                    }
                    
                    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/wtFaEntityUserGet.json",BASEURL]
                                                       params:para
                                                   completion:^(id json, JSONModelError *err) {
                                                       
                                                       //check err, process json ...
                                                       FMWtFaEntityUserGet *model = [[FMWtFaEntityUserGet alloc] initWithDictionary:json error:nil];
                                                       
                                                       if (!model.isSuccess)
                                                       {
                                                           [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                       }
                                                       else
                                                       {
                                                           [[Configuration Instance] setAvatar: [[NSString stringWithFormat:@"%@/%@",Prefix,model.avatar] URLEncodedStringFix]];
                                                           [Configuration Instance].sex = model.sex;
                                                           [Configuration Instance].birthday = model.birthday;
                                                            [Configuration Instance].userName = model.name;
                                                           
                                                           [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                                           /**
                                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
                                                            */
                                                           
                                                       }
                                                       [subscriber sendCompleted];
                                                   }];
                    
                    return nil;
                }];
    }];

}



@end
