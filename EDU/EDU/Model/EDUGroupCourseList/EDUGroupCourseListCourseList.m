//
//  EDUGroupCourseListCourseList.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListCourseList.h"
#import "EDUGroupCourseListResTags.h"
#import "EDUGroupCourseListResAuth.h"


NSString *const kEDUGroupCourseListCourseListId = @"id";
NSString *const kEDUGroupCourseListCourseListThumb = @"thumb";
NSString *const kEDUGroupCourseListCourseListTimeShow = @"timeShow";
NSString *const kEDUGroupCourseListCourseListResTags = @"resTags";
NSString *const kEDUGroupCourseListCourseListHasFavourite = @"hasFavourite";
NSString *const kEDUGroupCourseListCourseListMemo = @"memo";
NSString *const kEDUGroupCourseListCourseListDescr = @"descr";
NSString *const kEDUGroupCourseListCourseListAuth = @"auth";
NSString *const kEDUGroupCourseListCourseListUrl = @"url";
NSString *const kEDUGroupCourseListCourseListSfrom = @"sfrom";
NSString *const kEDUGroupCourseListCourseListTag = @"tag";
NSString *const kEDUGroupCourseListCourseListTitle = @"title";
NSString *const kEDUGroupCourseListCourseListAddTimeShow = @"addTimeShow";
NSString *const kEDUGroupCourseListCourseListCanShow = @"canShow";
NSString *const kEDUGroupCourseListCourseListResAuth = @"resAuth";
NSString *const kEDUGroupCourseListCourseListDuration = @"duration";
NSString *const kEDUGroupCourseListCourseListZan = @"zan";
NSString *const kEDUGroupCourseListCourseListSort = @"sort";


@interface EDUGroupCourseListCourseList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListCourseList

@synthesize courseListIdentifier = _courseListIdentifier;
@synthesize thumb = _thumb;
@synthesize timeShow = _timeShow;
@synthesize resTags = _resTags;
@synthesize hasFavourite = _hasFavourite;
@synthesize memo = _memo;
@synthesize descr = _descr;
@synthesize auth = _auth;
@synthesize url = _url;
@synthesize sfrom = _sfrom;
@synthesize tag = _tag;
@synthesize title = _title;
@synthesize addTimeShow = _addTimeShow;
@synthesize canShow = _canShow;
@synthesize resAuth = _resAuth;
@synthesize duration = _duration;
@synthesize zan = _zan;
@synthesize sort = _sort;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.courseListIdentifier = [[self objectOrNilForKey:kEDUGroupCourseListCourseListId fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kEDUGroupCourseListCourseListThumb fromDictionary:dict];
            self.timeShow = [self objectOrNilForKey:kEDUGroupCourseListCourseListTimeShow fromDictionary:dict];
    NSObject *receivedEDUGroupCourseListResTags = [dict objectForKey:kEDUGroupCourseListCourseListResTags];
    NSMutableArray *parsedEDUGroupCourseListResTags = [NSMutableArray array];
    
    if ([receivedEDUGroupCourseListResTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUGroupCourseListResTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUGroupCourseListResTags addObject:[EDUGroupCourseListResTags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUGroupCourseListResTags isKindOfClass:[NSDictionary class]]) {
       [parsedEDUGroupCourseListResTags addObject:[EDUGroupCourseListResTags modelObjectWithDictionary:(NSDictionary *)receivedEDUGroupCourseListResTags]];
    }

    self.resTags = [NSArray arrayWithArray:parsedEDUGroupCourseListResTags];
            self.hasFavourite = [self objectOrNilForKey:kEDUGroupCourseListCourseListHasFavourite fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUGroupCourseListCourseListMemo fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUGroupCourseListCourseListDescr fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDUGroupCourseListCourseListAuth fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUGroupCourseListCourseListUrl fromDictionary:dict];
            self.sfrom = [self objectOrNilForKey:kEDUGroupCourseListCourseListSfrom fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kEDUGroupCourseListCourseListTag fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUGroupCourseListCourseListTitle fromDictionary:dict];
            self.addTimeShow = [self objectOrNilForKey:kEDUGroupCourseListCourseListAddTimeShow fromDictionary:dict];
            self.canShow = [[self objectOrNilForKey:kEDUGroupCourseListCourseListCanShow fromDictionary:dict] boolValue];
            self.resAuth = [EDUGroupCourseListResAuth modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseListCourseListResAuth]];
            self.duration = [[self objectOrNilForKey:kEDUGroupCourseListCourseListDuration fromDictionary:dict] doubleValue];
            self.zan = [[self objectOrNilForKey:kEDUGroupCourseListCourseListZan fromDictionary:dict] doubleValue];
            self.sort = [[self objectOrNilForKey:kEDUGroupCourseListCourseListSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.courseListIdentifier] forKey:kEDUGroupCourseListCourseListId];
    [mutableDict setValue:self.thumb forKey:kEDUGroupCourseListCourseListThumb];
    [mutableDict setValue:self.timeShow forKey:kEDUGroupCourseListCourseListTimeShow];
    NSMutableArray *tempArrayForResTags = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.resTags) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResTags] forKey:kEDUGroupCourseListCourseListResTags];
    [mutableDict setValue:self.hasFavourite forKey:kEDUGroupCourseListCourseListHasFavourite];
    [mutableDict setValue:self.memo forKey:kEDUGroupCourseListCourseListMemo];
    [mutableDict setValue:self.descr forKey:kEDUGroupCourseListCourseListDescr];
    [mutableDict setValue:self.auth forKey:kEDUGroupCourseListCourseListAuth];
    [mutableDict setValue:self.url forKey:kEDUGroupCourseListCourseListUrl];
    [mutableDict setValue:self.sfrom forKey:kEDUGroupCourseListCourseListSfrom];
    [mutableDict setValue:self.tag forKey:kEDUGroupCourseListCourseListTag];
    [mutableDict setValue:self.title forKey:kEDUGroupCourseListCourseListTitle];
    [mutableDict setValue:self.addTimeShow forKey:kEDUGroupCourseListCourseListAddTimeShow];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kEDUGroupCourseListCourseListCanShow];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDUGroupCourseListCourseListResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUGroupCourseListCourseListDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.zan] forKey:kEDUGroupCourseListCourseListZan];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUGroupCourseListCourseListSort];

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

    self.courseListIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseListCourseListId];
    self.thumb = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListThumb];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListTimeShow];
    self.resTags = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListResTags];
    self.hasFavourite = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListHasFavourite];
    self.memo = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListMemo];
    self.descr = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListDescr];
    self.auth = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListAuth];
    self.url = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListUrl];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListSfrom];
    self.tag = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListTag];
    self.title = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListTitle];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListAddTimeShow];
    self.canShow = [aDecoder decodeBoolForKey:kEDUGroupCourseListCourseListCanShow];
    self.resAuth = [aDecoder decodeObjectForKey:kEDUGroupCourseListCourseListResAuth];
    self.duration = [aDecoder decodeDoubleForKey:kEDUGroupCourseListCourseListDuration];
    self.zan = [aDecoder decodeDoubleForKey:kEDUGroupCourseListCourseListZan];
    self.sort = [aDecoder decodeDoubleForKey:kEDUGroupCourseListCourseListSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_courseListIdentifier forKey:kEDUGroupCourseListCourseListId];
    [aCoder encodeObject:_thumb forKey:kEDUGroupCourseListCourseListThumb];
    [aCoder encodeObject:_timeShow forKey:kEDUGroupCourseListCourseListTimeShow];
    [aCoder encodeObject:_resTags forKey:kEDUGroupCourseListCourseListResTags];
    [aCoder encodeObject:_hasFavourite forKey:kEDUGroupCourseListCourseListHasFavourite];
    [aCoder encodeObject:_memo forKey:kEDUGroupCourseListCourseListMemo];
    [aCoder encodeObject:_descr forKey:kEDUGroupCourseListCourseListDescr];
    [aCoder encodeObject:_auth forKey:kEDUGroupCourseListCourseListAuth];
    [aCoder encodeObject:_url forKey:kEDUGroupCourseListCourseListUrl];
    [aCoder encodeObject:_sfrom forKey:kEDUGroupCourseListCourseListSfrom];
    [aCoder encodeObject:_tag forKey:kEDUGroupCourseListCourseListTag];
    [aCoder encodeObject:_title forKey:kEDUGroupCourseListCourseListTitle];
    [aCoder encodeObject:_addTimeShow forKey:kEDUGroupCourseListCourseListAddTimeShow];
    [aCoder encodeBool:_canShow forKey:kEDUGroupCourseListCourseListCanShow];
    [aCoder encodeObject:_resAuth forKey:kEDUGroupCourseListCourseListResAuth];
    [aCoder encodeDouble:_duration forKey:kEDUGroupCourseListCourseListDuration];
    [aCoder encodeDouble:_zan forKey:kEDUGroupCourseListCourseListZan];
    [aCoder encodeDouble:_sort forKey:kEDUGroupCourseListCourseListSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListCourseList *copy = [[EDUGroupCourseListCourseList alloc] init];
    
    
    
    if (copy) {

        copy.courseListIdentifier = self.courseListIdentifier;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.timeShow = [self.timeShow copyWithZone:zone];
        copy.resTags = [self.resTags copyWithZone:zone];
        copy.hasFavourite = [self.hasFavourite copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.auth = [self.auth copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.sfrom = [self.sfrom copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.canShow = self.canShow;
        copy.resAuth = [self.resAuth copyWithZone:zone];
        copy.duration = self.duration;
        copy.zan = self.zan;
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
