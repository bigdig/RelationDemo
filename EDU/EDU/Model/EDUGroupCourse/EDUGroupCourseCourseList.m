//
//  EDUGroupCourseCourseList.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupCourseCourseList.h"
#import "EDUGroupCourseResAuth.h"


NSString *const kEDUGroupCourseCourseListId = @"id";
NSString *const kEDUGroupCourseCourseListThumb = @"thumb";
NSString *const kEDUGroupCourseCourseListTimeShow = @"timeShow";
NSString *const kEDUGroupCourseCourseListHasFavourite = @"hasFavourite";
NSString *const kEDUGroupCourseCourseListDescr = @"descr";
NSString *const kEDUGroupCourseCourseListAuth = @"auth";
NSString *const kEDUGroupCourseCourseListUrl = @"url";
NSString *const kEDUGroupCourseCourseListSfrom = @"sfrom";
NSString *const kEDUGroupCourseCourseListTitle = @"title";
NSString *const kEDUGroupCourseCourseListAddTimeShow = @"addTimeShow";
NSString *const kEDUGroupCourseCourseListResAuth = @"resAuth";
NSString *const kEDUGroupCourseCourseListCanShow = @"canShow";
NSString *const kEDUGroupCourseCourseListDuration = @"duration";
NSString *const kEDUGroupCourseCourseListSort = @"sort";


@interface EDUGroupCourseCourseList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseCourseList

@synthesize courseListIdentifier = _courseListIdentifier;
@synthesize thumb = _thumb;
@synthesize timeShow = _timeShow;
@synthesize hasFavourite = _hasFavourite;
@synthesize descr = _descr;
@synthesize auth = _auth;
@synthesize url = _url;
@synthesize sfrom = _sfrom;
@synthesize title = _title;
@synthesize addTimeShow = _addTimeShow;
@synthesize resAuth = _resAuth;
@synthesize canShow = _canShow;
@synthesize duration = _duration;
@synthesize sort = _sort;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.courseListIdentifier = [[self objectOrNilForKey:kEDUGroupCourseCourseListId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUGroupCourseCourseListThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUGroupCourseCourseListTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUGroupCourseCourseListHasFavourite fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUGroupCourseCourseListDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUGroupCourseCourseListAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUGroupCourseCourseListUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUGroupCourseCourseListSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUGroupCourseCourseListTitle fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUGroupCourseCourseListAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUGroupCourseResAuth modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseCourseListResAuth]];
            self.canShow = [[self objectOrNilForKey:kEDUGroupCourseCourseListCanShow fromDictionary:dict] boolValue];
            self.duration = [[self objectOrNilForKey:kEDUGroupCourseCourseListDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUGroupCourseCourseListSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.courseListIdentifier] forKey:kEDUGroupCourseCourseListId];
    [mutableDict setValue:self.thumb forKey:kEDUGroupCourseCourseListThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUGroupCourseCourseListTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUGroupCourseCourseListHasFavourite];
    [mutableDict setValue:self.descr forKey:kEDUGroupCourseCourseListDescr];
    [mutableDict setValue:self.auth forKey:kEDUGroupCourseCourseListAuth];
    [mutableDict setValue:self.url forKey:kEDUGroupCourseCourseListUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUGroupCourseCourseListSfrom];
    [mutableDict setValue:self.title forKey:kEDUGroupCourseCourseListTitle];
    [mutableDict setValue:self.addTimeShow forKey:kEDUGroupCourseCourseListAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUGroupCourseCourseListResAuth];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kEDUGroupCourseCourseListCanShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUGroupCourseCourseListDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUGroupCourseCourseListSort];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.courseListIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseCourseListId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListHasFavourite];
    self.descr = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListTitle];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUGroupCourseCourseListResAuth];
    self.canShow = [aDecoder decodeBoolForKey:kEDUGroupCourseCourseListCanShow];
    self.duration = [aDecoder decodeDoubleForKey:kEDUGroupCourseCourseListDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUGroupCourseCourseListSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_courseListIdentifier forKey:kEDUGroupCourseCourseListId];
    [aCoder encodeObject:_thumb forKey:kEDUGroupCourseCourseListThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUGroupCourseCourseListTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUGroupCourseCourseListHasFavourite];
    [aCoder encodeObject:_descr forKey:kEDUGroupCourseCourseListDescr];
    [aCoder encodeObject:_auth forKey:kEDUGroupCourseCourseListAuth];
    [aCoder encodeObject:_url forKey:kEDUGroupCourseCourseListUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUGroupCourseCourseListSfrom];
    [aCoder encodeObject:_title forKey:kEDUGroupCourseCourseListTitle];
    [aCoder encodeObject:_addTimeShow forKey:kEDUGroupCourseCourseListAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUGroupCourseCourseListResAuth];
    [aCoder encodeBool:_canShow forKey:kEDUGroupCourseCourseListCanShow];
    [aCoder encodeDouble:_duration forKey:kEDUGroupCourseCourseListDuration];
    [aCoder encodeDouble:_sort forKey:kEDUGroupCourseCourseListSort];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupCourseCourseList *copy = [[EDUGroupCourseCourseList alloc] init];
    
    if (copy) {

        copy.courseListIdentifier = self.courseListIdentifier;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.timeShow = [self.timeShow copyWithZone:zone];
        copy.hasFavourite = [self.hasFavourite copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.auth = [self.auth copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.sfrom = [self.sfrom copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.resAuth = [self.resAuth copyWithZone:zone];
        copy.canShow = self.canShow;
        copy.duration = self.duration;
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
