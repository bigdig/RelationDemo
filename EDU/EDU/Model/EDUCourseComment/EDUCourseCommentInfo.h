//
//  EDUCourseCommentInfo.h
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUCourseCommentSacUser, EDUCourseCommentResCourse;

@interface EDUCourseCommentInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *words;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) EDUCourseCommentSacUser *sacUser;
@property (nonatomic, strong) EDUCourseCommentResCourse *resCourse;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
