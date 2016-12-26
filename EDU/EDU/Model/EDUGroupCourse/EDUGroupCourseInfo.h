//
//  EDUGroupCourseInfo.h
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUGroupCourseGroup;

@interface EDUGroupCourseInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) EDUGroupCourseGroup *group;
@property (nonatomic, strong) NSArray  * courseList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
