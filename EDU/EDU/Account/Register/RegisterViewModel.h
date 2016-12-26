//
//  RegisterViewModel.h
//  DressingCollection
//
//  Created by renxingguo on 16/4/20.
//  Copyright © 2016年 北京伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RegisterViewModel : NSObject

@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *verifyCode;
@property (nonatomic,strong) NSString *invitationCode;
@property (nonatomic,strong) NSString *name;

@property (nonatomic, strong, readonly) RACSignal *enableRegisterSignal;
@property (nonatomic, strong, readonly) RACCommand *registerCommand;

@end
