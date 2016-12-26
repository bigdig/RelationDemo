//
//  ProfileViewModel.h
//  EDU
//
//  Created by renxingguo on 16/9/9.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMProfileViewModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) UIImage *faceImage;
@property (nonatomic,strong) NSString *birthday;

@property (nonatomic, strong, readonly) RACSignal *enableSignal;
@property (nonatomic, strong, readonly) RACCommand *saveProfileCommand;

@end
