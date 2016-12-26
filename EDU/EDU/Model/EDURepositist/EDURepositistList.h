//
//  EDURepositistList.h
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDURepositistResAuth, EDURepositistResRepCls;

@interface EDURepositistList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sort;
@property (nonatomic, strong) EDURepositistResAuth *resAuth;
@property (nonatomic, assign) double listIdentifier;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) EDURepositistResRepCls *resRepCls;
@property (nonatomic, assign) double size;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *auth;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL canShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
