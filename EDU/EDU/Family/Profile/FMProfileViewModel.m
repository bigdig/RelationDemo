//
//  ProfileViewModel.m
//  EDU
//
//  Created by renxingguo on 16/9/9.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMProfileViewModel.h"
#import "NSString+MD5.h"
#import "JSONHTTPClient.h"
#import "BloomFilter.h"
#import "FMLoginModel.h"
#import "NSObject+PostImageHttps.h"

@interface WtFaUserUpdModel : JSONModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation WtFaUserUpdModel

- (BOOL)isSuccess
{
    return self.code == 0;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"info.recode": @"code",
                                                       @"info.redesc":@"message"
                                                       
                                                       }];
}

@end



@implementation FMProfileViewModel


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
    self.sex=[Configuration Instance].sex;
    self.birthday=[Configuration Instance].birthday;
    
    // 监听账号的属性值改变，把他们聚合成一个信号。
     _enableSignal = [RACSignal combineLatest:@[RACObserve(self, name),RACObserve(self, sex),RACObserve(self, birthday),RACObserve(self, birthday) ] reduce:^id(NSString *s1,NSString *s2,NSString *s3,NSString *s4){
     return @([s1 length]>0&& [s2 length]>0);
     }];
    
    // 处理登录业务逻辑
    _saveProfileCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    
                    NSMutableDictionary* para= [[NSMutableDictionary alloc] initWithDictionary: @{@"user_id":[Configuration Instance].userID
                                                                                                  }];
                    if (self.birthday) {
                        [para setObject:self.birthday forKey:@"birthday"];
                    }
                    if (self.name) {
                        [para setObject:self.name forKey:@"name"];
                    }
                    if (self.sex) {
                        [para setObject:[self.sex compare:@"男"]== NSOrderedSame ? @"1":@"0" forKey:@"sex"];
                    }
                    
                    UIImage *image = self.faceImage;
                    
                    [self requestPostUrlWithImage:@"wtFaUserUpd.json" parameters:para image:image success:^(NSDictionary *responce) {
                        
                        
                        //check err, process json ...
                        WtFaUserUpdModel *model = [[WtFaUserUpdModel alloc] initWithDictionary:responce error:nil];
                        
                        if (!model.isSuccess)
                        {
                            [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                            [subscriber sendCompleted];
                        }
                        else
                        {
 
                            //syn
                            FMSynUserInfoModel *syn = [[FMSynUserInfoModel alloc] init];
                            [[syn.command execute:nil] subscribeNext:^(id x) {
                                [subscriber sendNext:RACTuplePack(@(YES),model.message)];
                                [subscriber sendCompleted];
                            }];
                            
                        }
                        

                        
                    } failure:^(NSError *error) {
                        ;
                    }];
                    
                    return nil;
                }];
    }];
    
}


@end
