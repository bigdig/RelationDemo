//
//  ProfileViewModel.h
//  EDU
//
//  Created by renxingguo on 16/9/9.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileViewModel : NSObject

@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *specialty;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *award;

@property (nonatomic, strong, readonly) RACSignal *enableSignal;
@property (nonatomic, strong, readonly) RACCommand *saveProfileCommand;

@end
