//
//  EDUGroupCourseListInfo.h
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUGroupCourseListGroup;

@interface EDUGroupCourseListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) EDUGroupCourseListGroup *group;
@property (nonatomic, strong) NSArray *courseList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
