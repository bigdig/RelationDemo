//
//  CourseDetailInfo.h
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CourseDetailCourse;

@interface CourseDetailInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double commentNum;
@property (nonatomic, strong) NSArray *others;
@property (nonatomic, strong) CourseDetailCourse *course;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
