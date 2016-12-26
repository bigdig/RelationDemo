//
//  EDUUserFavouriteResCourse.h
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUUserFavouriteResAuth;

@interface EDUUserFavouriteResCourse : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resCourseIdentifier;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, assign) id hasFavourite;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *auth;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *sfrom;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) EDUUserFavouriteResAuth *resAuth;
@property (nonatomic, assign) id canShow;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
