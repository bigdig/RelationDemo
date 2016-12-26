//
//  Config.m
//  DressingCollection
//
//  Created by renxingguo on 15/9/22.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "Configuration.h"
#import "ReactiveCocoa.h"

@implementation Configuration

- (void)saveUserID:(NSString *)userID andUserName:(NSString *)userName andUserRank:(NSString *)userRank andRankName:(NSString *)rankName andRankImg:(NSString *)rankImg andPhone:(NSString *)phoneNumber ;
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    
    self.userID = userID;
    self.userName = userName;
    self.userRank = userRank;
    self.rankImg = rankImg;
    self.phoneNumber = phoneNumber;
    
    self.cookie = @(YES);
    [settings synchronize];
}

-(BOOL)isCookie
{
    return self.cookie;
}

- (void)checkout
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    self.cookie = NO;
    
    self.userID = @"";
    self.userName = @"FALSE";
    self.needBackgroundRunning = @"";
    self.userRank = @"";
    self.rankImg = @"";
    self.phoneNumber = @"";
    
    self.rongToken = @"";
    self.avatar = @"";
    
    [settings synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGOUT_SUCCESS" object:nil];
}

static Configuration * instance = nil;
//获取单例
+ (Configuration *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
            //            instance = [[self alloc]init];
            [instance bind];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}



- (void)bind
{
    //use reactive
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    @weakify(self);
    
    RACChannelTo(self,fitDictionary) = [defaults rac_channelTerminalForKey:@"fitDictionary"];
    if (nil == self.fitDictionary) {
        self.fitDictionary = [NSMutableDictionary dictionary];
    }
//    //fit dictionary should be mutable
    self.fitDictionary = [[NSMutableDictionary alloc] initWithDictionary:self.fitDictionary];
    
    {
        //historyPlayRecords
        RACChannelTo(self, historyPlayRecords) = [defaults rac_channelTerminalForKey:@"historyPlayRecords"];
        if (nil==_historyPlayRecords || [_historyPlayRecords count]==0) {
            self.historyPlayRecords = [[NSMutableArray alloc] init];
        }
        self.historyPlayRecords = [[NSMutableArray alloc] initWithArray:self.historyPlayRecords];
    }
    
    RACChannelTo(self,sex) = [defaults rac_channelTerminalForKey:@"sex"];
    RACChannelTo(self,age) = [defaults rac_channelTerminalForKey:@"age"];
    RACChannelTo(self,wardrobeID) = [defaults rac_channelTerminalForKey:@"wardrobeID"];
    RACChannelTo(self,birthday) = [defaults rac_channelTerminalForKey:@"birthday"];
    
    RACChannelTo(self,cookie) = [defaults rac_channelTerminalForKey:@"cookie"];
    RACChannelTo(self,userID) = [defaults rac_channelTerminalForKey:@"userID"];
    RACChannelTo(self,userName) = [defaults rac_channelTerminalForKey:@"userName"];
    RACChannelTo(self,needBackgroundRunning) = [defaults rac_channelTerminalForKey:@"needBackgroundRunning"];
    RACChannelTo(self,userRank) = [defaults rac_channelTerminalForKey:@"userRank"];
    RACChannelTo(self,rankImg) = [defaults rac_channelTerminalForKey:@"rankImg"];
    
    RACChannelTo(self,phoneNumber) = [defaults rac_channelTerminalForKey:@"phoneNumber"];
    RACChannelTo(self,password) = [defaults rac_channelTerminalForKey:@"password"];
    RACChannelTo(self,alipay) = [defaults rac_channelTerminalForKey:@"alipay"];
    RACChannelTo(self,alipayName) = [defaults rac_channelTerminalForKey:@"alipayName"];
    
    RACChannelTo(self,rongToken) = [defaults rac_channelTerminalForKey:@"rongToken"];
    RACChannelTo(self,avatar) = [defaults rac_channelTerminalForKey:@"avatar"];
    
    //body
    RACChannelTo(self,bodySex) = [defaults rac_channelTerminalForKey:@"bodySex"];
    RACChannelTo(self,bodyHeight) = [defaults rac_channelTerminalForKey:@"bodyHeight"];
    RACChannelTo(self,bodyWeight) = [defaults rac_channelTerminalForKey:@"bodyWeight"];
    RACChannelTo(self,bodyBust) = [defaults rac_channelTerminalForKey:@"bodyBust"];
    RACChannelTo(self,bodyWaist) = [defaults rac_channelTerminalForKey:@"bodyWaist"];
    RACChannelTo(self,bodyHip) = [defaults rac_channelTerminalForKey:@"bodyHip"];
    
    RACChannelTo(self,bodyShould) = [defaults rac_channelTerminalForKey:@"bodyShould"];
    RACChannelTo(self,bodyArm) = [defaults rac_channelTerminalForKey:@"bodyArm"];
    RACChannelTo(self,bodyLeg) = [defaults rac_channelTerminalForKey:@"bodyLeg"];
    RACChannelTo(self,bodyNeck) = [defaults rac_channelTerminalForKey:@"bodyNeck"];
    RACChannelTo(self,bodyWrist) = [defaults rac_channelTerminalForKey:@"bodyWrist"];
    RACChannelTo(self,bodyFoot) = [defaults rac_channelTerminalForKey:@"bodyFoot"];
    
    RACChannelTo(self,mid) = [defaults rac_channelTerminalForKey:@"mid"];
    
    
    RACChannelTo(self,lastSignInTime) = [defaults rac_channelTerminalForKey:@"lastSignInTime"];
    
    RACChannelTo(self,grade) = [defaults rac_channelTerminalForKey:@"grade"];
    RACChannelTo(self,school) = [defaults rac_channelTerminalForKey:@"school"];
    RACChannelTo(self,specialty) = [defaults rac_channelTerminalForKey:@"specialty"];
    RACChannelTo(self,train) = [defaults rac_channelTerminalForKey:@"train"];
    RACChannelTo(self,award) = [defaults rac_channelTerminalForKey:@"award"];
    RACChannelTo(self,award) = [defaults rac_channelTerminalForKey:@"email"];
    RACChannelTo(self,award) = [defaults rac_channelTerminalForKey:@"qq"];
    
    //map bodysex value
    [RACObserve(self, bodySex) subscribeNext:^(id x) {
        if ([self.bodySex compare:@"男" ] == NSOrderedSame) {
            self.sex = @"1";
        }
        else
            self.sex = @"2";
    }];
    
    [RACObserve(self, userID) subscribeNext:^(NSString *x) {
        @strongify(self);
        if (!self.cookie) {
            return;
        }
        
        if(self.userID && [self.userID length])
        {
            [self updateInfo];
        }
    }
     ];
    
}

#define RemoveUnit(par) ([par stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [par length])])
#define AvoidNil(par) (par)?(RemoveUnit(par)):@"0"
#define AvoidNilSimple(par) (par)?(par):@"0"

- (void)synBodyParamToServer
{
    if (!self.cookie) {
        return;
    }
    if (self.wardrobeID && [self.wardrobeID length]) {
        //syn to server
        NSDictionary* para= @{@"user_id":AvoidNilSimple(self.userID),
                              @"wardrobe_id":AvoidNilSimple(self.wardrobeID),
                              @"sex": AvoidNilSimple(self.sex),
                              @"birthday": AvoidNilSimple(self.birthday),
                              @"height":AvoidNil(self.bodyHeight),
                              @"weight": AvoidNil(self.bodyWeight),
                              @"chest":AvoidNil(self.bodyBust),
                              @"waistline":AvoidNil(self.bodyWaist),
                              @"hipline":AvoidNil(self.bodyHip),
                              @"jiankuan":AvoidNil(self.bodyShould),
                              @"bichang":AvoidNil(self.bodyArm),
                              //                              @"yaoweigao":self.body
                              @"jingwei":AvoidNil(self.bodyNeck),
                              @"wanwei":AvoidNil(self.bodyWrist),
                              @"tuichang":AvoidNil(self.bodyLeg),
                              @"xiema":AvoidNil(self.bodyFoot)
                              };
        
//        [[[STMQuickObjectMapper objectManagerWithBaseurl:BASEURL] rac_getPath:@"wtNewWardrobeUpdate.json" parameters:para] subscribeNext:^(RKMappingResult* mappingResult) {
//            DBNewWardrobeUpdateModle *model = [[mappingResult array] firstObject];
//            NSLog(@"%@",model.message);
//            NSLog(@"%@", [mappingResult array]);
//            
//            if (!model.isSuccess)
//            {
//                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.redesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alter show];
//            }
//            else
//            {
//                //do nothing
//            }
//        } error:^(NSError *error) {
//            ;
//        }
//         ];
    }
}

- (void)updateInfo
{
    //update wardrobe
    NSDictionary* para= @{@"user_id":self.userID
                          };
//    [[[STMQuickObjectMapper objectManagerWithBaseurl:BASEURL] rac_getPath:@"wtNewWardrobeGet.json" parameters:para] subscribeNext:^(RKMappingResult* mappingResult) {
//        DBNewWardrobeGetModel *model = [[mappingResult array] firstObject];
//        NSLog(@"%@",model.message);
//        NSLog(@"%@", [mappingResult array]);
//        
//        if (!model.isSuccess)
//        {
//            //            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.redesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            //            [alter show];
//        }
//        else
//        {
//            self.wardrobeID = model.wardrobeId;
//            self.sex = model.sex;
//            if ([model.sex integerValue] == 1) {
//                self.bodySex = @"男";
//            }
//            else
//                self.bodySex = @"女";
//            
//            self.bodyHeight = [NSString stringWithFormat:@"%@ cm", model.height];
//            self.bodyWeight = [NSString stringWithFormat:@"%@ kg", model.weight];
//            self.birthday = model.birthdayShow;
//            self.bodyWaist = [NSString stringWithFormat:@"%@ cm", model.waistline];
//            self.bodyBust = [NSString stringWithFormat:@"%@ cm", model.chest];
//            self.bodyHip = [NSString stringWithFormat:@"%@ cm", model.hipline];
//            self.age = model.age;
//            self.mid = model.mid;
//            
//            //to add
//        }
//    } error:^(NSError *error) {
//        ;
//    }
//     ];
}

@end
