//
//  EDUGroupCourseListCourseList.h
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUGroupCourseListResAuth;

@interface EDUGroupCourseListCourseList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double courseListIdentifier;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, strong) NSArray *resTags;
@property (nonatomic, assign) id hasFavourite;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *auth;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) id sfrom;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, assign) BOOL canShow;
@property (nonatomic, strong) EDUGroupCourseListResAuth *resAuth;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double zan;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
