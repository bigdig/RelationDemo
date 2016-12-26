//
//  LoginViewModel.h
//  DressingCollection
//
//  Created by renxingguo on 16/4/20.
//  Copyright © 2016年 北京伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface LoginViewModel : NSObject

@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;
@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end
