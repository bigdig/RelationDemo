//
//  FMWtFaUserLoginModel.h
//  EDU
//
//  Created by renxingguo on 2016/12/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FMWtFaUserLoginModel : JSONModel
/**
 {"code":1,"message":"success","info":{"user_id":88763,"user_name":"袁东华","mobile_phone":"18801123830","avatar":"/data/avatar/2015/09/02/14/88763/.png","recode":"4","redesc":"成功!"}
 */
@property (nonatomic,strong) NSString<Optional> *user_id;
@property (nonatomic,strong) NSString<Optional> *name;
@property (nonatomic,strong) NSString<Optional> *mobile;
@property (nonatomic,strong) NSString<Optional> *avatar;
@property (nonatomic,strong) NSString<Optional> *pwd;
@property (nonatomic,strong) NSString<Optional> *sex;
@property (nonatomic,strong) NSString<Optional> *wxid;
@property (nonatomic,strong) NSString<Optional> *wxnick;
@property (nonatomic,strong) NSString<Optional> *wxpic;

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end



@interface FMWtFaEntityUserGet : JSONModel
/**
{"code":1,"message":"success","info":{"recode":0,"redesc":"成功","entityUser":{"id":74,"name":"兴国","sex":1,"birthdayShow":"1991-12-27","mobile":"18610116950","faUser":{"id":42,"name":"兴国","pwd":null,"mobile":"18610116950","sex":1,"pic":"/data/photo/default_pic.jpg","wxid":"o3LILj6brjbkgq-A6bUXsJCL-180","wxnick":null,"wxpic":null},"relationWithMe":null,"pic":"/data/photo/default_pic.jpg","myFamily":[]}}}
 */
@property (nonatomic,strong) NSString<Optional> *user_id;
@property (nonatomic,strong) NSString<Optional> *name;
@property (nonatomic,strong) NSString<Optional> *mobile;
@property (nonatomic,strong) NSString<Optional> *avatar;
@property (nonatomic,strong) NSString<Optional> *pwd;
@property (nonatomic,strong) NSString<Optional> *sex;
@property (nonatomic,strong) NSString<Optional> *birthday;
@property (nonatomic,strong) NSString<Optional> *wxid;
@property (nonatomic,strong) NSString<Optional> *wxnick;
@property (nonatomic,strong) NSString<Optional> *wxpic;

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end
