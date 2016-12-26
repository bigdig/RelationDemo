//
//  EDUCourseTaskResCourse.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseTaskResCourse.h"
#import "EDUCourseTaskResAuth.h"


NSString *const kEDUCourseTaskResCourseId = @"id";
NSString *const kEDUCourseTaskResCourseThumb = @"thumb";
NSString *const kEDUCourseTaskResCourseTimeShow = @"timeShow";
NSString *const kEDUCourseTaskResCourseHasFavourite = @"hasFavourite";
NSString *const kEDUCourseTaskResCourseMemo = @"memo";
NSString *const kEDUCourseTaskResCourseDescr = @"descr";
NSString *const kEDUCourseTaskResCourseAuth = @"auth";
NSString *const kEDUCourseTaskResCourseUrl = @"url";
NSString *const kEDUCourseTaskResCourseSfrom = @"sfrom";
NSString *const kEDUCourseTaskResCourseTitle = @"title";
NSString *const kEDUCourseTaskResCourseCanShow = @"canShow";
NSString *const kEDUCourseTaskResCourseAddTimeShow = @"addTimeShow";
NSString *const kEDUCourseTaskResCourseResAuth = @"resAuth";
NSString *const kEDUCourseTaskResCourseDuration = @"duration";
NSString *const kEDUCourseTaskResCourseSort = @"sort";


@interface EDUCourseTaskResCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseTaskResCourse

@synthesize resCourseIdentifier = _resCourseIdentifier;
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


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resCourseIdentifier = [[self objectOrNilForKey:kEDUCourseTaskResCourseId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUCourseTaskResCourseThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUCourseTaskResCourseTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUCourseTaskResCourseHasFavourite fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUCourseTaskResCourseMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUCourseTaskResCourseDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUCourseTaskResCourseAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUCourseTaskResCourseUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUCourseTaskResCourseSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUCourseTaskResCourseTitle fromDictionary:dict];
            self.canShow = [self objectOrNilForKey:kEDUCourseTaskResCourseCanShow fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUCourseTaskResCourseAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUCourseTaskResAuth modelObjectWithDictionary:[dict objectForKey:kEDUCourseTaskResCourseResAuth]];
            self.duration = [[self objectOrNilForKey:kEDUCourseTaskResCourseDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUCourseTaskResCourseSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resCourseIdentifier] forKey:kEDUCourseTaskResCourseId];
    [mutableDict setValue:self.thumb forKey:kEDUCourseTaskResCourseThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUCourseTaskResCourseTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUCourseTaskResCourseHasFavourite];
    [mutableDict setValue:self.memo forKey:kEDUCourseTaskResCourseMemo];
    [mutableDict setValue:self.descr forKey:kEDUCourseTaskResCourseDescr];
    [mutableDict setValue:self.auth forKey:kEDUCourseTaskResCourseAuth];
    [mutableDict setValue:self.url forKey:kEDUCourseTaskResCourseUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUCourseTaskResCourseSfrom];
    [mutableDict setValue:self.title forKey:kEDUCourseTaskResCourseTitle];
    [mutableDict setValue:self.canShow forKey:kEDUCourseTaskResCourseCanShow];
    [mutableDict setValue:self.addTimeShow forKey:kEDUCourseTaskResCourseAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUCourseTaskResCourseResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUCourseTaskResCourseDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUCourseTaskResCourseSort];

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

    self.resCourseIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseTaskResCourseId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseMemo];
    self.descr = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseTitle];
    self.canShow = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseCanShow];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUCourseTaskResCourseResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kEDUCourseTaskResCourseDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUCourseTaskResCourseSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resCourseIdentifier forKey:kEDUCourseTaskResCourseId];
    [aCoder encodeObject:_thumb forKey:kEDUCourseTaskResCourseThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUCourseTaskResCourseTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUCourseTaskResCourseHasFavourite];
    [aCoder encodeObject:_memo forKey:kEDUCourseTaskResCourseMemo];
    [aCoder encodeObject:_descr forKey:kEDUCourseTaskResCourseDescr];
    [aCoder encodeObject:_auth forKey:kEDUCourseTaskResCourseAuth];
    [aCoder encodeObject:_url forKey:kEDUCourseTaskResCourseUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUCourseTaskResCourseSfrom];
    [aCoder encodeObject:_title forKey:kEDUCourseTaskResCourseTitle];
    [aCoder encodeObject:_canShow forKey:kEDUCourseTaskResCourseCanShow];
    [aCoder encodeObject:_addTimeShow forKey:kEDUCourseTaskResCourseAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUCourseTaskResCourseResAuth];
    [aCoder encodeDouble:_duration forKey:kEDUCourseTaskResCourseDuration];
    [aCoder encodeDouble:_sort forKey:kEDUCourseTaskResCourseSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseTaskResCourse *copy = [[EDUCourseTaskResCourse alloc] init];
    
    
    
    if (copy) {

        copy.resCourseIdentifier = self.resCourseIdentifier;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.timeShow = [self.timeShow copyWithZone:zone];
        copy.hasFavourite = [self.hasFavourite copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.auth = [self.auth copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.sfrom = [self.sfrom copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.canShow = [self.canShow copyWithZone:zone];
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.resAuth = [self.resAuth copyWithZone:zone];
        copy.duration = self.duration;
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
