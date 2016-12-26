//
//  CourseDetailInfo.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailInfo.h"
#import "CourseDetailOthers.h"
#import "CourseDetailCourse.h"


NSString *const kCourseDetailInfoCommentNum = @"commentNum";
NSString *const kCourseDetailInfoOthers = @"others";
NSString *const kCourseDetailInfoCourse = @"course";


@interface CourseDetailInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetailInfo

@synthesize commentNum = _commentNum;
@synthesize others = _others;
@synthesize course = _course;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.commentNum = [[self objectOrNilForKey:kCourseDetailInfoCommentNum fromDictionary:dict] doubleValue];
    NSObject *receivedCourseDetailOthers = [dict objectForKey:kCourseDetailInfoOthers];
    NSMutableArray *parsedCourseDetailOthers = [NSMutableArray array];
    
    if ([receivedCourseDetailOthers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCourseDetailOthers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCourseDetailOthers addObject:[CourseDetailOthers modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCourseDetailOthers isKindOfClass:[NSDictionary class]]) {
       [parsedCourseDetailOthers addObject:[CourseDetailOthers modelObjectWithDictionary:(NSDictionary *)receivedCourseDetailOthers]];
    }

    self.others = [NSArray arrayWithArray:parsedCourseDetailOthers];
            self.course = [CourseDetailCourse modelObjectWithDictionary:[dict objectForKey:kCourseDetailInfoCourse]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentNum] forKey:kCourseDetailInfoCommentNum];
    NSMutableArray *tempArrayForOthers = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.others) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOthers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOthers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOthers] forKey:kCourseDetailInfoOthers];
    [mutableDict setValue:[self.course dictionaryRepresentation] forKey:kCourseDetailInfoCourse];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.commentNum = [aDecoder decodeDoubleForKey:kCourseDetailInfoCommentNum];
    self.others = [aDecoder decodeObjectForKey:kCourseDetailInfoOthers];
    self.course = [aDecoder decodeObjectForKey:kCourseDetailInfoCourse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_commentNum forKey:kCourseDetailInfoCommentNum];
    [aCoder encodeObject:_others forKey:kCourseDetailInfoOthers];
    [aCoder encodeObject:_course forKey:kCourseDetailInfoCourse];
}

- (id)copyWithZone:(NSZone *)zone {
    CourseDetailInfo *copy = [[CourseDetailInfo alloc] init];
    
    
    
    if (copy) {

        copy.commentNum = self.commentNum;
        copy.others = [self.others copyWithZone:zone];
        copy.course = [self.course copyWithZone:zone];
    }
    
    return copy;
}


@end
