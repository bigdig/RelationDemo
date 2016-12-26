//
//  EDUCourseTaskResCourse.h
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUCourseTaskResAuth;

@interface EDUCourseTaskResCourse : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resCourseIdentifier;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, assign) id hasFavourite;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *auth;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *sfrom;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) id canShow;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) EDUCourseTaskResAuth *resAuth;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
