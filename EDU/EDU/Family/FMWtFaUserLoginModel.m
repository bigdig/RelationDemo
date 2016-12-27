//
//  FMWtFaUserLoginModel.m
//  EDU
//
//  Created by renxingguo on 2016/12/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMWtFaUserLoginModel.h"

@implementation FMWtFaUserLoginModel

/**
 1：微信用户不存在，请绑定手机注册；
 0：登录成功;
 */
- (BOOL)isSuccess
{
    return self.code == 0;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"info.recode": @"code",
                                                       @"info.redesc":@"message",
                                                       @"info.faUser.id":@"user_id",
                                                       @"info.faUser.name":@"name",
                                                       @"info.faUser.mobile":@"mobile",
                                                       @"info.faUser.pic":@"avatar",
                                                       @"info.faUser.pwd":@"pwd",
                                                       @"info.faUser.sex":@"sex",
                                                       @"info.faUser.wxid":@"wxid",
                                                       @"info.faUser.wxnick":@"wxnick",
                                                       @"info.faUser.wxpic":@"wxpic",
                                                       
                                                       }];
}

@end

