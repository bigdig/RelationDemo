//
//  FMFamilyProfileViewModel.h
//  EDU
//
//  Created by renxingguo on 2016/12/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMFamilyProfileViewModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) UIImage *faceImage;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *named;
@property (nonatomic,strong) NSString *reverseNamed;
@property (nonatomic,strong) NSString *code; //世系代码

@property (nonatomic, strong, readonly) RACSignal *enableSignal;
@property (nonatomic, strong, readonly) RACCommand *saveProfileCommand;

@property (nonatomic, strong, readonly) RACCommand *reverseRelationCommand;


@end
