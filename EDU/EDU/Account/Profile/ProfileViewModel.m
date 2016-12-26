//
//  ProfileViewModel.m
//  EDU
//
//  Created by renxingguo on 16/9/9.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "ProfileViewModel.h"

#import "NSString+MD5.h"
#import "JSONHTTPClient.h"
#import "BloomFilter.h"

@interface SacUserInfoUpdWtModel : JSONModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation SacUserInfoUpdWtModel

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



@implementation ProfileViewModel


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
    self.name= [Configuration Instance].userName;
    self.school=[Configuration Instance].school;
    self.grade=[Configuration Instance].grade;
    self.specialty = [Configuration Instance].specialty;
    self.award = [Configuration Instance].award;
    // 监听账号的属性值改变，把他们聚合成一个信号。
    _enableSignal = [RACSignal combineLatest:@[RACObserve(self, school),RACObserve(self, grade),RACObserve(self, specialty),RACObserve(self, name)] reduce:^id(NSString *s1,NSString *s2,NSString *s3,NSString *s4){
        return @([s1 length]>0&& [s2 length]>0);
    }];
    
    // 处理登录业务逻辑
    _saveProfileCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    
                    NSMutableDictionary* para= [[NSMutableDictionary alloc] initWithDictionary: @{@"user_id":[Configuration Instance].userID,
                                          @"logname":self.name,
                                          @"school":self.school,
                                          @"grade": self.grade
                                                }];
                    if ([self.specialty length] >0 ) {
                        [para setObject:self.specialty forKey:@"specialty"];
                    }
                    if ([self.award length] >0 ) {
                        [para setObject:self.award
                                 forKey:@"award"];
                    }
                    
                    [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/sacUserInfoUpdWt.json",BASEURL]
                                                       params:para
                                                   completion:^(id json, JSONModelError *err) {
                                                       
                                                       //check err, process json ...
                                                       SacUserInfoUpdWtModel *model = [[SacUserInfoUpdWtModel alloc] initWithDictionary:json error:nil];
                                                       
                                                       if (!model.isSuccess)
                                                       {
                                                           [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                       }
                                                       else
                                                       {
                                                           [Configuration Instance].school = self.school;
                                                           [Configuration Instance].grade = self.grade;
                                                           [Configuration Instance].specialty = self.specialty;
                                                           [Configuration Instance].award = self.award;
                                                           
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_PROFILE_SUCCESS" object:nil];
                                                           [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                                           
                                                       }
                                                       [subscriber sendCompleted];
                                                   }];
                    
                    return nil;
                }];
    }];
}

@end
