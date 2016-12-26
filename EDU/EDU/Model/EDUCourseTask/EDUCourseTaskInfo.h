//
//  EDUCourseTaskInfo.h
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUCourseTaskResCourse;

@interface EDUCourseTaskInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, assign) double tag;
@property (nonatomic, strong) NSString *answerShow;
@property (nonatomic, strong) EDUCourseTaskResCourse *resCourse;
@property (nonatomic, assign) double state;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
