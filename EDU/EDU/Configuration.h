//
//  Config.h
//  DressingCollection
//
//  Created by renxingguo on 15/9/22.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

//从好友顾问点到衣柜的时候，保存xx的用户id
@property (retain, nonatomic) NSString *friendid;
@property (retain, nonatomic) NSMutableArray *attireList;
@property (retain, nonatomic) NSString *attireCount;
@property (retain, nonatomic) NSString *attiretime; //方案发布时间
@property (assign, nonatomic) int attireSelectedIndex;
@property (assign, nonatomic) int   body_sex;     //0:男  ,1:女
@property (assign, nonatomic) int   body_mstd;    //标准体重
@property (assign, nonatomic) float body_height;  //身高
@property (assign, nonatomic) float body_weight;  //体重
@property (assign, nonatomic) float body_bust;    //胸围
@property (assign, nonatomic) float body_waist;   //腰围
@property (assign, nonatomic) float body_hip;     //臀围

@property (assign, nonatomic) int agegroup;
//
@property (assign, nonatomic) BOOL updateWardrobe; //更新衣柜标志

//run time value
@property (strong,nonatomic) id faceImage;

@property (strong,nonatomic) NSString *occassion; //buy add request
@property (strong,nonatomic) NSString *attirexSex; //男装 女装
@property (strong,nonatomic) NSDictionary *searchDictionary; //atire search dictionary

//buyer request detail run time value
@property (strong,nonatomic) NSDictionary *buyerRequest; //当前查看的需求详情
@property (strong,nonatomic) NSDictionary *buyerResponse; //当前查看的推荐详情
@property (strong,nonatomic) NSString *currentWebURL;

//爱心捐衣相关
@property (strong,nonatomic) NSString *currentDotationProjectID;

//签到时间
@property (strong,nonatomic) NSDate *lastSignInTime;

//runtime value
@property (assign,nonatomic) NSInteger dzClassID; //当前查看的定制类型ID

@property (assign,nonatomic) double current_course_id;
@property (assign,nonatomic) double current_group_id;
@property (strong,nonatomic) NSString *current_video_url;
@property (strong,nonatomic) NSString *current_video_url_title;
@property (assign,nonatomic) double current_work_id;

@property (strong,nonatomic) NSString *tagName;
@property (strong,nonatomic) NSString *tagID;

@property (assign,nonatomic) BOOL resetPassword;

/**
 * fitAttireURL 设置路径后，会自动试穿，结果存在 lastestFitResult
 */
@property (strong,nonatomic) NSString *fitAttireURL; //试衣方案路径
@property (strong,nonatomic) NSString *lastestFitResult; //最近试衣结果

//persistent array
@property (strong,atomic) NSMutableDictionary *fitDictionary; //试衣结果列表

//persistent birthday
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *wardrobeID;

//persistent property
@property (strong, nonatomic) NSNumber *cookie;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userRank;

@property (strong, nonatomic) NSString *rankImg;
@property (strong, nonatomic) NSString *phoneNumber; //用户手机号

@property (strong, nonatomic) NSString *alipay; //ali pay number
@property (strong, nonatomic) NSString *alipayName; //ali pay name

@property (strong, nonatomic) NSString *userName;
@property (assign, nonatomic) NSString* needBackgroundRunning;

@property (strong, nonatomic) NSString *password; //md5 password

@property (strong,nonatomic) NSString *rongToken; //rong token
@property (strong,nonatomic) NSString *avatar; //rong token

@property (strong,nonatomic) NSString *sex; //1:男  ,2:女

//persisten body property
@property (strong, nonatomic) NSString *bodySex;     //0:男  ,1:女
@property (strong, nonatomic) NSString *bodyHeight;  //身高
@property (strong, nonatomic) NSString *bodyWeight;  //体重
@property (strong, nonatomic) NSString *bodyBust;    //胸围
@property (strong, nonatomic) NSString *bodyWaist;   //腰围
@property (strong, nonatomic) NSString *bodyHip;     //臀围

@property (strong, nonatomic) NSString *bodyShould;     //should
@property (strong, nonatomic) NSString *bodyArm;     //arm length
@property (strong, nonatomic) NSString *bodyLeg;     //

@property (strong, nonatomic) NSString *bodyNeck;     //
@property (strong, nonatomic) NSString *bodyWrist;     //
@property (strong, nonatomic) NSString *bodyFoot;

@property (strong, nonatomic) NSString *mid;

@property (strong, nonatomic) NSString *employer_id;
@property (strong, nonatomic) NSString *vip;

@property (strong, nonatomic) NSString *wxopenid; //wechat open id
@property (strong, nonatomic) NSString *wxaccess_token; //wechat access_token

@property (strong, nonatomic) NSArray *historyPlayRecords;

@property (strong,nonatomic) NSString *school;
@property (strong,nonatomic) NSString *grade;
@property (strong,nonatomic) NSString *specialty;
@property (strong,nonatomic) NSString *award;
@property (strong,nonatomic) NSString *train;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *qq;

@property (strong,nonatomic) NSString *verifyCode;
////保存登录用户名以及密码
- (void)saveUserID:(NSString *)userID andUserName:(NSString *)userName andUserRank:(NSString *)userRank andRankName:(NSString *)rankName andRankImg:(NSString *)rankImg andPhone:(NSString *)phoneNumber;

- (void)checkout;

- (BOOL)isCookie;

- (void)synBodyParamToServer;

+ (Configuration *) Instance;
+ (id)allocWithZone:(NSZone *)zone;

@end
