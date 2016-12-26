//
//  CourseDetailCourse.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailCourse.h"
#import "CourseDetailResAuth.h"


NSString *const kCourseDetailCourseId = @"id";
NSString *const kCourseDetailCourseThumb = @"thumb";
NSString *const kCourseDetailCourseTimeShow = @"timeShow";
NSString *const kCourseDetailCourseHasFavourite = @"hasFavourite";
NSString *const kCourseDetailCourseMemo = @"memo";
NSString *const kCourseDetailCourseDescr = @"descr";
NSString *const kCourseDetailCourseAuth = @"auth";
NSString *const kCourseDetailCourseUrl = @"url";
NSString *const kCourseDetailCourseSfrom = @"sfrom";
NSString *const kCourseDetailCourseTitle = @"title";
NSString *const kCourseDetailCourseCanShow = @"canShow";
NSString *const kCourseDetailCourseAddTimeShow = @"addTimeShow";
NSString *const kCourseDetailCourseResAuth = @"resAuth";
NSString *const kCourseDetailCourseDuration = @"duration";
NSString *const kCourseDetailCourseSort = @"sort";
NSString *const kCourseDetailCourseZan = @"zan";


@interface CourseDetailCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetailCourse

@synthesize courseIdentifier = _courseIdentifier;
@synthesize thumb = _thumb;
@synthesize timeShow = _timeShow;
@synthesize hasFavourite = _hasFavourite;
@synthesize memo = _memo;
@synthesize descr = _descr;
@synthesize auth = _auth;
@synthesize url = _url;
@synthesize sfrom = _sfrom;
@synthesize title = _title;
@synthesize canShow = _canShow;
@synthesize addTimeShow = _addTimeShow;
@synthesize resAuth = _resAuth;
@synthesize duration = _duration;
@synthesize sort = _sort;
@synthesize zan = _zan;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.courseIdentifier = [[self objectOrNilForKey:kCourseDetailCourseId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kCourseDetailCourseThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kCourseDetailCourseTimeShow fromDictionary:dict];
            self.hasFavourite = [[self objectOrNilForKey:kCourseDetailCourseHasFavourite fromDictionary:dict] boolValue];
            self.memo = [self objectOrNilForKey:kCourseDetailCourseMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kCourseDetailCourseDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kCourseDetailCourseAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kCourseDetailCourseUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kCourseDetailCourseSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kCourseDetailCourseTitle fromDictionary:dict];
            self.canShow = [[self objectOrNilForKey:kCourseDetailCourseCanShow fromDictionary:dict] boolValue];
            self.addTimeShow = [self objectOrNilForKey:kCourseDetailCourseAddTimeShow fromDictionary:dict];
            self.resAuth = [CourseDetailResAuth modelObjectWithDictionary:[dict objectForKey:kCourseDetailCourseResAuth]];
            self.duration = [[self objectOrNilForKey:kCourseDetailCourseDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kCourseDetailCourseSort fromDictionary:dict] doubleValue];
        
            self.zan = [[self objectOrNilForKey:kCourseDetailCourseZan fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.courseIdentifier] forKey:kCourseDetailCourseId];
    [mutableDict setValue:self.thumb forKey:kCourseDetailCourseThumb];
    [mutableDict setValue:self.timeShow forKey:kCourseDetailCourseTimeShow];
    [mutableDict setValue:[NSNumber numberWithBool:self.hasFavourite] forKey:kCourseDetailCourseHasFavourite];
    [mutableDict setValue:self.memo forKey:kCourseDetailCourseMemo];
    [mutableDict setValue:self.descr forKey:kCourseDetailCourseDescr];
    [mutableDict setValue:self.auth forKey:kCourseDetailCourseAuth];
    [mutableDict setValue:self.url forKey:kCourseDetailCourseUrl];
    [mutableDict setValue:self.sfrom forKey:kCourseDetailCourseSfrom];
    [mutableDict setValue:self.title forKey:kCourseDetailCourseTitle];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kCourseDetailCourseCanShow];
    [mutableDict setValue:self.addTimeShow forKey:kCourseDetailCourseAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kCourseDetailCourseResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kCourseDetailCourseDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kCourseDetailCourseSort];
    
    [mutableDict setValue:[NSNumber numberWithDouble:self.zan] forKey:kCourseDetailCourseZan];

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

    self.courseIdentifier = [aDecoder decodeDoubleForKey:kCourseDetailCourseId];
    self.thumb = [aDecoder decodeObjectForKey:kCourseDetailCourseThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kCourseDetailCourseTimeShow];
    self.hasFavourite = [aDecoder decodeBoolForKey:kCourseDetailCourseHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kCourseDetailCourseMemo];
    self.descr = [aDecoder decodeObjectForKey:kCourseDetailCourseDescr];
    self.auth = [aDecoder decodeObjectForKey:kCourseDetailCourseAuth];
    self.url = [aDecoder decodeObjectForKey:kCourseDetailCourseUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kCourseDetailCourseSfrom];
    self.title = [aDecoder decodeObjectForKey:kCourseDetailCourseTitle];
    self.canShow = [aDecoder decodeBoolForKey:kCourseDetailCourseCanShow];
    self.addTimeShow = [aDecoder decodeObjectForKey:kCourseDetailCourseAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kCourseDetailCourseResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kCourseDetailCourseDuration];
    self.sort = [aDecoder decodeDoubleForKey:kCourseDetailCourseSort];
    self.zan = [aDecoder decodeDoubleForKey:kCourseDetailCourseZan];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_courseIdentifier forKey:kCourseDetailCourseId];
    [aCoder encodeObject:_thumb forKey:kCourseDetailCourseThumb];
    [aCoder encodeObject:_timeShow forKey:kCourseDetailCourseTimeShow];
    [aCoder encodeBool:_hasFavourite forKey:kCourseDetailCourseHasFavourite];
    [aCoder encodeObject:_memo forKey:kCourseDetailCourseMemo];
    [aCoder encodeObject:_descr forKey:kCourseDetailCourseDescr];
    [aCoder encodeObject:_auth forKey:kCourseDetailCourseAuth];
    [aCoder encodeObject:_url forKey:kCourseDetailCourseUrl];
    [aCoder encodeObject:_sfrom forKey:kCourseDetailCourseSfrom];
    [aCoder encodeObject:_title forKey:kCourseDetailCourseTitle];
    [aCoder encodeBool:_canShow forKey:kCourseDetailCourseCanShow];
    [aCoder encodeObject:_addTimeShow forKey:kCourseDetailCourseAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kCourseDetailCourseResAuth];
    [aCoder encodeDouble:_duration forKey:kCourseDetailCourseDuration];
    [aCoder encodeDouble:_sort forKey:kCourseDetailCourseSort];
    [aCoder encodeDouble:_zan forKey:kCourseDetailCourseZan];
}

- (id)copyWithZone:(NSZone *)zone {
    CourseDetailCourse *copy = [[CourseDetailCourse alloc] init];
    
    
    
    if (copy) {

        copy.courseIdentifier = self.courseIdentifier;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.timeShow = [self.timeShow copyWithZone:zone];
        copy.hasFavourite = self.hasFavourite;
        copy.memo = [self.memo copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.auth = [self.auth copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.sfrom = [self.sfrom copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.canShow = self.canShow;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.resAuth = [self.resAuth copyWithZone:zone];
        copy.duration = self.duration;
        copy.sort = self.sort;
        copy.zan = self.zan;
    }
    
    return copy;
}


@end
