//
//  CourseDetailOthers.h
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CourseDetailResAuth;

@interface CourseDetailOthers : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double othersIdentifier;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, assign) BOOL hasFavourite;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *auth;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) id sfrom;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL canShow;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) CourseDetailResAuth *resAuth;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
