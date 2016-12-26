//
//  EDUCourseCommentResCourse.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentResCourse.h"
#import "EDUCourseCommentResAuth.h"


NSString *const kEDUCourseCommentResCourseId = @"id";
NSString *const kEDUCourseCommentResCourseThumb = @"thumb";
NSString *const kEDUCourseCommentResCourseTimeShow = @"timeShow";
NSString *const kEDUCourseCommentResCourseHasFavourite = @"hasFavourite";
NSString *const kEDUCourseCommentResCourseMemo = @"memo";
NSString *const kEDUCourseCommentResCourseDescr = @"descr";
NSString *const kEDUCourseCommentResCourseAuth = @"auth";
NSString *const kEDUCourseCommentResCourseUrl = @"url";
NSString *const kEDUCourseCommentResCourseSfrom = @"sfrom";
NSString *const kEDUCourseCommentResCourseTitle = @"title";
NSString *const kEDUCourseCommentResCourseCanShow = @"canShow";
NSString *const kEDUCourseCommentResCourseAddTimeShow = @"addTimeShow";
NSString *const kEDUCourseCommentResCourseResAuth = @"resAuth";
NSString *const kEDUCourseCommentResCourseDuration = @"duration";
NSString *const kEDUCourseCommentResCourseSort = @"sort";


@interface EDUCourseCommentResCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentResCourse

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
            self.resCourseIdentifier = [[self objectOrNilForKey:kEDUCourseCommentResCourseId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUCourseCommentResCourseThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUCourseCommentResCourseTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUCourseCommentResCourseHasFavourite fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUCourseCommentResCourseMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUCourseCommentResCourseDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUCourseCommentResCourseAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUCourseCommentResCourseUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUCourseCommentResCourseSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUCourseCommentResCourseTitle fromDictionary:dict];
            self.canShow = [self objectOrNilForKey:kEDUCourseCommentResCourseCanShow fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUCourseCommentResCourseAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUCourseCommentResAuth modelObjectWithDictionary:[dict objectForKey:kEDUCourseCommentResCourseResAuth]];
            self.duration = [[self objectOrNilForKey:kEDUCourseCommentResCourseDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUCourseCommentResCourseSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resCourseIdentifier] forKey:kEDUCourseCommentResCourseId];
    [mutableDict setValue:self.thumb forKey:kEDUCourseCommentResCourseThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUCourseCommentResCourseTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUCourseCommentResCourseHasFavourite];
    [mutableDict setValue:self.memo forKey:kEDUCourseCommentResCourseMemo];
    [mutableDict setValue:self.descr forKey:kEDUCourseCommentResCourseDescr];
    [mutableDict setValue:self.auth forKey:kEDUCourseCommentResCourseAuth];
    [mutableDict setValue:self.url forKey:kEDUCourseCommentResCourseUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUCourseCommentResCourseSfrom];
    [mutableDict setValue:self.title forKey:kEDUCourseCommentResCourseTitle];
    [mutableDict setValue:self.canShow forKey:kEDUCourseCommentResCourseCanShow];
    [mutableDict setValue:self.addTimeShow forKey:kEDUCourseCommentResCourseAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUCourseCommentResCourseResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUCourseCommentResCourseDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUCourseCommentResCourseSort];

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

    self.resCourseIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseCommentResCourseId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseMemo];
    self.descr = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseTitle];
    self.canShow = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseCanShow];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUCourseCommentResCourseResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kEDUCourseCommentResCourseDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUCourseCommentResCourseSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resCourseIdentifier forKey:kEDUCourseCommentResCourseId];
    [aCoder encodeObject:_thumb forKey:kEDUCourseCommentResCourseThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUCourseCommentResCourseTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUCourseCommentResCourseHasFavourite];
    [aCoder encodeObject:_memo forKey:kEDUCourseCommentResCourseMemo];
    [aCoder encodeObject:_descr forKey:kEDUCourseCommentResCourseDescr];
    [aCoder encodeObject:_auth forKey:kEDUCourseCommentResCourseAuth];
    [aCoder encodeObject:_url forKey:kEDUCourseCommentResCourseUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUCourseCommentResCourseSfrom];
    [aCoder encodeObject:_title forKey:kEDUCourseCommentResCourseTitle];
    [aCoder encodeObject:_canShow forKey:kEDUCourseCommentResCourseCanShow];
    [aCoder encodeObject:_addTimeShow forKey:kEDUCourseCommentResCourseAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUCourseCommentResCourseResAuth];
    [aCoder encodeDouble:_duration forKey:kEDUCourseCommentResCourseDuration];
    [aCoder encodeDouble:_sort forKey:kEDUCourseCommentResCourseSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentResCourse *copy = [[EDUCourseCommentResCourse alloc] init];
    
    
    
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
