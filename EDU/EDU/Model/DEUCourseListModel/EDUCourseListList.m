//
//  EDUCourseListList.m
//
//  Created by xingguo ren on 16/9/1
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUCourseListList.h"
#import "EDUCourseListResAuth.h"


NSString *const kEDUCourseListListId = @"id";
NSString *const kEDUCourseListListThumb = @"thumb";
NSString *const kEDUCourseListListTimeShow = @"timeShow";
NSString *const kEDUCourseListListHasFavourite = @"hasFavourite";
NSString *const kEDUCourseListListDescr = @"descr";
NSString *const kEDUCourseListListAuth = @"auth";
NSString *const kEDUCourseListListUrl = @"url";
NSString *const kEDUCourseListListSfrom = @"sfrom";
NSString *const kEDUCourseListListTitle = @"title";
NSString *const kEDUCourseListListAddTimeShow = @"addTimeShow";
NSString *const kEDUCourseListListResAuth = @"resAuth";
NSString *const kEDUCourseListListCanShow = @"canShow";
NSString *const kEDUCourseListListDuration = @"duration";
NSString *const kEDUCourseListListSort = @"sort";


@interface EDUCourseListList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseListList

@synthesize listIdentifier = _listIdentifier;
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
            self.listIdentifier = [[self objectOrNilForKey:kEDUCourseListListId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUCourseListListThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUCourseListListTimeShow fromDictionary:dict];
            self.hasFavourite = [self objectOrNilForKey:kEDUCourseListListHasFavourite fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUCourseListListDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUCourseListListAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUCourseListListUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUCourseListListSfrom fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUCourseListListTitle fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUCourseListListAddTimeShow fromDictionary:dict];
            self.resAuth = [EDUCourseListResAuth modelObjectWithDictionary:[dict objectForKey:kEDUCourseListListResAuth]];
            self.canShow = [[self objectOrNilForKey:kEDUCourseListListCanShow fromDictionary:dict] boolValue];
            self.duration = [[self objectOrNilForKey:kEDUCourseListListDuration fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUCourseListListSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kEDUCourseListListId];
    [mutableDict setValue:self.thumb forKey:kEDUCourseListListThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUCourseListListTimeShow];
    [mutableDict setValue:self.hasFavourite forKey:kEDUCourseListListHasFavourite];
    [mutableDict setValue:self.descr forKey:kEDUCourseListListDescr];
    [mutableDict setValue:self.auth forKey:kEDUCourseListListAuth];
    [mutableDict setValue:self.url forKey:kEDUCourseListListUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUCourseListListSfrom];
    [mutableDict setValue:self.title forKey:kEDUCourseListListTitle];
    [mutableDict setValue:self.addTimeShow forKey:kEDUCourseListListAddTimeShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUCourseListListResAuth];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kEDUCourseListListCanShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUCourseListListDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUCourseListListSort];

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

    self.listIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseListListId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUCourseListListThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUCourseListListTimeShow];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUCourseListListHasFavourite];
    self.descr = [aDecoder decodeObjectForKey:kEDUCourseListListDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUCourseListListAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUCourseListListUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUCourseListListSfrom];
    self.title = [aDecoder decodeObjectForKey:kEDUCourseListListTitle];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUCourseListListAddTimeShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUCourseListListResAuth];
    self.canShow = [aDecoder decodeBoolForKey:kEDUCourseListListCanShow];
    self.duration = [aDecoder decodeDoubleForKey:kEDUCourseListListDuration];
    self.sort = [aDecoder decodeDoubleForKey:kEDUCourseListListSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_listIdentifier forKey:kEDUCourseListListId];
    [aCoder encodeObject:_thumb forKey:kEDUCourseListListThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUCourseListListTimeShow];
    [aCoder encodeObject:_hasFavourite forKey:kEDUCourseListListHasFavourite];
    [aCoder encodeObject:_descr forKey:kEDUCourseListListDescr];
    [aCoder encodeObject:_auth forKey:kEDUCourseListListAuth];
    [aCoder encodeObject:_url forKey:kEDUCourseListListUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUCourseListListSfrom];
    [aCoder encodeObject:_title forKey:kEDUCourseListListTitle];
    [aCoder encodeObject:_addTimeShow forKey:kEDUCourseListListAddTimeShow];
    [aCoder encodeObject:_resAuth forKey:kEDUCourseListListResAuth];
    [aCoder encodeBool:_canShow forKey:kEDUCourseListListCanShow];
    [aCoder encodeDouble:_duration forKey:kEDUCourseListListDuration];
    [aCoder encodeDouble:_sort forKey:kEDUCourseListListSort];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUCourseListList *copy = [[EDUCourseListList alloc] init];
    
    if (copy) {

        copy.listIdentifier = self.listIdentifier;
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
