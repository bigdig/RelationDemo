//
//  CourseDetailOthers.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailOthers.h"
#import "CourseDetailResAuth.h"


NSString *const kCourseDetailOthersId = @"id";
NSString *const kCourseDetailOthersThumb = @"thumb";
NSString *const kCourseDetailOthersTimeShow = @"timeShow";
NSString *const kCourseDetailOthersHasFavourite = @"hasFavourite";
NSString *const kCourseDetailOthersMemo = @"memo";
NSString *const kCourseDetailOthersDescr = @"descr";
NSString *const kCourseDetailOthersAuth = @"auth";
NSString *const kCourseDetailOthersUrl = @"url";
NSString *const kCourseDetailOthersSfrom = @"sfrom";
NSString *const kCourseDetailOthersTitle = @"title";
NSString *const kCourseDetailOthersCanShow = @"canShow";
NSString *const kCourseDetailOthersAddTimeShow = @"addTimeShow";
NSString *const kCourseDetailOthersResAuth = @"resAuth";
NSString *const kCourseDetailOthersDuration = @"duration";
NSString *const kCourseDetailOthersSort = @"sort";


@interface CourseDetailOthers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetailOthers

@synthesize othersIdentifier = _othersIdentifier;
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
            self.othersIdentifier = [[self objectOrNilForKey:kCourseDetailOthersId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kCourseDetailOthersThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kCourseDetailOthersTimeShow fromDictionary:dict];
            self.hasFavourite = [[self objectOrNilForKey:kCourseDetailOthersHasFavourite fromDictionary:dict] boolValue];
            self.memo = [self objectOrNilForKey:kCourseDetailOthersMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kCourseDetailOthersDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kCourseDetailOthersAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kCourseDetailOthersUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kCourseDetailOthersSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kCourseDetailOthersTitle fromDictionary:dict];
            self.canShow = [[self objectOrNilForKey:kCourseDetailOthersCanShow fromDictionary:dict] boolValue];
            self.addTimeShow = [self objectOrNilForKey:kCourseDetailOthersAddTimeShow fromDictionary:dict];
            self.resAuth = [CourseDetailResAuth modelObjectWithDictionary:[dict objectForKey:kCourseDetailOthersResAuth]];
            self.duration = [[self objectOrNilForKey:kCourseDetailOthersDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kCourseDetailOthersSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.othersIdentifier] forKey:kCourseDetailOthersId];
    [mutableDict setValue:self.thumb forKey:kCourseDetailOthersThumb];
    [mutableDict setValue:self.timeShow forKey:kCourseDetailOthersTimeShow];
    [mutableDict setValue:[NSNumber numberWithBool:self.hasFavourite] forKey:kCourseDetailOthersHasFavourite];
    [mutableDict setValue:self.memo forKey:kCourseDetailOthersMemo];
    [mutableDict setValue:self.descr forKey:kCourseDetailOthersDescr];
    [mutableDict setValue:self.auth forKey:kCourseDetailOthersAuth];
    [mutableDict setValue:self.url forKey:kCourseDetailOthersUrl];
    [mutableDict setValue:self.sfrom forKey:kCourseDetailOthersSfrom];
    [mutableDict setValue:self.title forKey:kCourseDetailOthersTitle];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kCourseDetailOthersCanShow];
    [mutableDict setValue:self.addTimeShow forKey:kCourseDetailOthersAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kCourseDetailOthersResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kCourseDetailOthersDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kCourseDetailOthersSort];

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

    self.othersIdentifier = [aDecoder decodeDoubleForKey:kCourseDetailOthersId];
    self.thumb = [aDecoder decodeObjectForKey:kCourseDetailOthersThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kCourseDetailOthersTimeShow];
    self.hasFavourite = [aDecoder decodeBoolForKey:kCourseDetailOthersHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kCourseDetailOthersMemo];
    self.descr = [aDecoder decodeObjectForKey:kCourseDetailOthersDescr];
    self.auth = [aDecoder decodeObjectForKey:kCourseDetailOthersAuth];
    self.url = [aDecoder decodeObjectForKey:kCourseDetailOthersUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kCourseDetailOthersSfrom];
    self.title = [aDecoder decodeObjectForKey:kCourseDetailOthersTitle];
    self.canShow = [aDecoder decodeBoolForKey:kCourseDetailOthersCanShow];
    self.addTimeShow = [aDecoder decodeObjectForKey:kCourseDetailOthersAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kCourseDetailOthersResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kCourseDetailOthersDuration];
    self.sort = [aDecoder decodeDoubleForKey:kCourseDetailOthersSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_othersIdentifier forKey:kCourseDetailOthersId];
    [aCoder encodeObject:_thumb forKey:kCourseDetailOthersThumb];
    [aCoder encodeObject:_timeShow forKey:kCourseDetailOthersTimeShow];
    [aCoder encodeBool:_hasFavourite forKey:kCourseDetailOthersHasFavourite];
    [aCoder encodeObject:_memo forKey:kCourseDetailOthersMemo];
    [aCoder encodeObject:_descr forKey:kCourseDetailOthersDescr];
    [aCoder encodeObject:_auth forKey:kCourseDetailOthersAuth];
    [aCoder encodeObject:_url forKey:kCourseDetailOthersUrl];
    [aCoder encodeObject:_sfrom forKey:kCourseDetailOthersSfrom];
    [aCoder encodeObject:_title forKey:kCourseDetailOthersTitle];
    [aCoder encodeBool:_canShow forKey:kCourseDetailOthersCanShow];
    [aCoder encodeObject:_addTimeShow forKey:kCourseDetailOthersAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kCourseDetailOthersResAuth];
    [aCoder encodeDouble:_duration forKey:kCourseDetailOthersDuration];
    [aCoder encodeDouble:_sort forKey:kCourseDetailOthersSort];
}

- (id)copyWithZone:(NSZone *)zone {
    CourseDetailOthers *copy = [[CourseDetailOthers alloc] init];
    
    
    
    if (copy) {

        copy.othersIdentifier = self.othersIdentifier;
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
    }
    
    return copy;
}


@end
