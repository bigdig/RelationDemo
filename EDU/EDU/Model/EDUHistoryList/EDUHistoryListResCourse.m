//
//  EDUHistoryListResCourse.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListResCourse.h"
#import "EDUHistoryListResAuth.h"


NSString *const kEDUHistoryListResCourseId = @"id";
NSString *const kEDUHistoryListResCourseThumb = @"thumb";
NSString *const kEDUHistoryListResCourseTimeShow = @"timeShow";
NSString *const kEDUHistoryListResCourseHasFavourite = @"hasFavourite";
NSString *const kEDUHistoryListResCourseMemo = @"memo";
NSString *const kEDUHistoryListResCourseDescr = @"descr";
NSString *const kEDUHistoryListResCourseAuth = @"auth";
NSString *const kEDUHistoryListResCourseUrl = @"url";
NSString *const kEDUHistoryListResCourseSfrom = @"sfrom";
NSString *const kEDUHistoryListResCourseTitle = @"title";
NSString *const kEDUHistoryListResCourseCanShow = @"canShow";
NSString *const kEDUHistoryListResCourseAddTimeShow = @"addTimeShow";
NSString *const kEDUHistoryListResCourseResAuth = @"resAuth";
NSString *const kEDUHistoryListResCourseDuration = @"duration";
NSString *const kEDUHistoryListResCourseSort = @"sort";


@interface EDUHistoryListResCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListResCourse

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
            self.resCourseIdentifier = [[self objectOrNilForKey:kEDUHistoryListResCourseId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUHistoryListResCourseThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUHistoryListResCourseTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUHistoryListResCourseHasFavourite fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUHistoryListResCourseMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUHistoryListResCourseDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUHistoryListResCourseAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUHistoryListResCourseUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUHistoryListResCourseSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUHistoryListResCourseTitle fromDictionary:dict];
            self.canShow = [self objectOrNilForKey:kEDUHistoryListResCourseCanShow fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUHistoryListResCourseAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUHistoryListResAuth modelObjectWithDictionary:[dict objectForKey:kEDUHistoryListResCourseResAuth]];
            self.duration = [[self objectOrNilForKey:kEDUHistoryListResCourseDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUHistoryListResCourseSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resCourseIdentifier] forKey:kEDUHistoryListResCourseId];
    [mutableDict setValue:self.thumb forKey:kEDUHistoryListResCourseThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUHistoryListResCourseTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUHistoryListResCourseHasFavourite];
    [mutableDict setValue:self.memo forKey:kEDUHistoryListResCourseMemo];
    [mutableDict setValue:self.descr forKey:kEDUHistoryListResCourseDescr];
    [mutableDict setValue:self.auth forKey:kEDUHistoryListResCourseAuth];
    [mutableDict setValue:self.url forKey:kEDUHistoryListResCourseUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUHistoryListResCourseSfrom];
    [mutableDict setValue:self.title forKey:kEDUHistoryListResCourseTitle];
    [mutableDict setValue:self.canShow forKey:kEDUHistoryListResCourseCanShow];
    [mutableDict setValue:self.addTimeShow forKey:kEDUHistoryListResCourseAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUHistoryListResCourseResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUHistoryListResCourseDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUHistoryListResCourseSort];

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

    self.resCourseIdentifier = [aDecoder decodeDoubleForKey:kEDUHistoryListResCourseId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseMemo];
    self.descr = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseTitle];
    self.canShow = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseCanShow];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUHistoryListResCourseResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kEDUHistoryListResCourseDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUHistoryListResCourseSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resCourseIdentifier forKey:kEDUHistoryListResCourseId];
    [aCoder encodeObject:_thumb forKey:kEDUHistoryListResCourseThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUHistoryListResCourseTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUHistoryListResCourseHasFavourite];
    [aCoder encodeObject:_memo forKey:kEDUHistoryListResCourseMemo];
    [aCoder encodeObject:_descr forKey:kEDUHistoryListResCourseDescr];
    [aCoder encodeObject:_auth forKey:kEDUHistoryListResCourseAuth];
    [aCoder encodeObject:_url forKey:kEDUHistoryListResCourseUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUHistoryListResCourseSfrom];
    [aCoder encodeObject:_title forKey:kEDUHistoryListResCourseTitle];
    [aCoder encodeObject:_canShow forKey:kEDUHistoryListResCourseCanShow];
    [aCoder encodeObject:_addTimeShow forKey:kEDUHistoryListResCourseAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUHistoryListResCourseResAuth];
    [aCoder encodeDouble:_duration forKey:kEDUHistoryListResCourseDuration];
    [aCoder encodeDouble:_sort forKey:kEDUHistoryListResCourseSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListResCourse *copy = [[EDUHistoryListResCourse alloc] init];
    
    
    
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
