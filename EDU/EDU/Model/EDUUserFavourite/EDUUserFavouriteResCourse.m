//
//  EDUUserFavouriteResCourse.m
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUUserFavouriteResCourse.h"
#import "EDUUserFavouriteResAuth.h"


NSString *const kEDUUserFavouriteResCourseId = @"id";
NSString *const kEDUUserFavouriteResCourseThumb = @"thumb";
NSString *const kEDUUserFavouriteResCourseTimeShow = @"timeShow";
NSString *const kEDUUserFavouriteResCourseHasFavourite = @"hasFavourite";
NSString *const kEDUUserFavouriteResCourseDescr = @"descr";
NSString *const kEDUUserFavouriteResCourseAuth = @"auth";
NSString *const kEDUUserFavouriteResCourseUrl = @"url";
NSString *const kEDUUserFavouriteResCourseSfrom = @"sfrom";
NSString *const kEDUUserFavouriteResCourseTitle = @"title";
NSString *const kEDUUserFavouriteResCourseAddTimeShow = @"addTimeShow";
NSString *const kEDUUserFavouriteResCourseResAuth = @"resAuth";
NSString *const kEDUUserFavouriteResCourseCanShow = @"canShow";
NSString *const kEDUUserFavouriteResCourseDuration = @"duration";
NSString *const kEDUUserFavouriteResCourseSort = @"sort";


@interface EDUUserFavouriteResCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUUserFavouriteResCourse

@synthesize resCourseIdentifier = _resCourseIdentifier;
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
            self.resCourseIdentifier = [[self objectOrNilForKey:kEDUUserFavouriteResCourseId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUUserFavouriteResCourseThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUUserFavouriteResCourseTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUUserFavouriteResCourseHasFavourite fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUUserFavouriteResCourseDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUUserFavouriteResCourseAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUUserFavouriteResCourseUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUUserFavouriteResCourseSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUUserFavouriteResCourseTitle fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUUserFavouriteResCourseAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUUserFavouriteResAuth modelObjectWithDictionary:[dict objectForKey:kEDUUserFavouriteResCourseResAuth]];
            self.canShow = [self objectOrNilForKey:kEDUUserFavouriteResCourseCanShow fromDictionary:dict];
            self.duration = [[self objectOrNilForKey:kEDUUserFavouriteResCourseDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUUserFavouriteResCourseSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resCourseIdentifier] forKey:kEDUUserFavouriteResCourseId];
    [mutableDict setValue:self.thumb forKey:kEDUUserFavouriteResCourseThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUUserFavouriteResCourseTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUUserFavouriteResCourseHasFavourite];
    [mutableDict setValue:self.descr forKey:kEDUUserFavouriteResCourseDescr];
    [mutableDict setValue:self.auth forKey:kEDUUserFavouriteResCourseAuth];
    [mutableDict setValue:self.url forKey:kEDUUserFavouriteResCourseUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUUserFavouriteResCourseSfrom];
    [mutableDict setValue:self.title forKey:kEDUUserFavouriteResCourseTitle];
    [mutableDict setValue:self.addTimeShow forKey:kEDUUserFavouriteResCourseAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUUserFavouriteResCourseResAuth];
    [mutableDict setValue:self.canShow forKey:kEDUUserFavouriteResCourseCanShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUUserFavouriteResCourseDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUUserFavouriteResCourseSort];

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

    self.resCourseIdentifier = [aDecoder decodeDoubleForKey:kEDUUserFavouriteResCourseId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseHasFavourite];
    self.descr = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseTitle];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseResAuth];
    self.canShow = [aDecoder decodeObjectForKey:kEDUUserFavouriteResCourseCanShow];
    self.duration = [aDecoder decodeDoubleForKey:kEDUUserFavouriteResCourseDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUUserFavouriteResCourseSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resCourseIdentifier forKey:kEDUUserFavouriteResCourseId];
    [aCoder encodeObject:_thumb forKey:kEDUUserFavouriteResCourseThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUUserFavouriteResCourseTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUUserFavouriteResCourseHasFavourite];
    [aCoder encodeObject:_descr forKey:kEDUUserFavouriteResCourseDescr];
    [aCoder encodeObject:_auth forKey:kEDUUserFavouriteResCourseAuth];
    [aCoder encodeObject:_url forKey:kEDUUserFavouriteResCourseUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUUserFavouriteResCourseSfrom];
    [aCoder encodeObject:_title forKey:kEDUUserFavouriteResCourseTitle];
    [aCoder encodeObject:_addTimeShow forKey:kEDUUserFavouriteResCourseAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUUserFavouriteResCourseResAuth];
    [aCoder encodeObject:_canShow forKey:kEDUUserFavouriteResCourseCanShow];
    [aCoder encodeDouble:_duration forKey:kEDUUserFavouriteResCourseDuration];
    [aCoder encodeDouble:_sort forKey:kEDUUserFavouriteResCourseSort];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUUserFavouriteResCourse *copy = [[EDUUserFavouriteResCourse alloc] init];
    
    if (copy) {

        copy.resCourseIdentifier = self.resCourseIdentifier;
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
        copy.canShow = [self.canShow copyWithZone:zone];
        copy.duration = self.duration;
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
