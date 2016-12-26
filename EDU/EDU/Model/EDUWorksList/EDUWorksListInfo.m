//
//  EDUWorksListInfo.m
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUWorksListInfo.h"


NSString *const kEDUWorksListInfoSort = @"sort";
NSString *const kEDUWorksListInfoSfrom = @"sfrom";
NSString *const kEDUWorksListInfoId = @"id";
NSString *const kEDUWorksListInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUWorksListInfoTitle = @"title";
NSString *const kEDUWorksListInfoDescr = @"descr";
NSString *const kEDUWorksListInfoThumb = @"thumb";
NSString *const kEDUWorksListInfoDuration = @"duration";
NSString *const kEDUWorksListInfoTimeShow = @"timeShow";
NSString *const kEDUWorksListInfoMemo = @"memo";
NSString *const kEDUWorksListInfoUrl = @"url";


@interface EDUWorksListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUWorksListInfo

@synthesize sort = _sort;
@synthesize sfrom = _sfrom;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize addTimeShow = _addTimeShow;
@synthesize title = _title;
@synthesize descr = _descr;
@synthesize thumb = _thumb;
@synthesize duration = _duration;
@synthesize timeShow = _timeShow;
@synthesize memo = _memo;
@synthesize url = _url;


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
            self.sort = [[self objectOrNilForKey:kEDUWorksListInfoSort fromDictionary:dict] doubleValue];
            self.sfrom = [self objectOrNilForKey:kEDUWorksListInfoSfrom fromDictionary:dict];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUWorksListInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUWorksListInfoAddTimeShow fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUWorksListInfoTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUWorksListInfoDescr fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kEDUWorksListInfoThumb fromDictionary:dict];
            self.duration = [[self objectOrNilForKey:kEDUWorksListInfoDuration fromDictionary:dict] doubleValue];
            self.timeShow = [self objectOrNilForKey:kEDUWorksListInfoTimeShow fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUWorksListInfoMemo fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUWorksListInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUWorksListInfoSort];
    [mutableDict setValue:self.sfrom forKey:kEDUWorksListInfoSfrom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUWorksListInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUWorksListInfoAddTimeShow];
    [mutableDict setValue:self.title forKey:kEDUWorksListInfoTitle];
    [mutableDict setValue:self.descr forKey:kEDUWorksListInfoDescr];
    [mutableDict setValue:self.thumb forKey:kEDUWorksListInfoThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUWorksListInfoDuration];
    [mutableDict setValue:self.timeShow forKey:kEDUWorksListInfoTimeShow];
    [mutableDict setValue:self.memo forKey:kEDUWorksListInfoMemo];
    [mutableDict setValue:self.url forKey:kEDUWorksListInfoUrl];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDUWorksListInfoSort];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUWorksListInfoSfrom];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUWorksListInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUWorksListInfoAddTimeShow];
    self.title = [aDecoder decodeObjectForKey:kEDUWorksListInfoTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUWorksListInfoDescr];
    self.thumb = [aDecoder decodeObjectForKey:kEDUWorksListInfoThumb];
    self.duration = [aDecoder decodeDoubleForKey:kEDUWorksListInfoDuration];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUWorksListInfoTimeShow];
    self.memo = [aDecoder decodeObjectForKey:kEDUWorksListInfoMemo];
    self.url = [aDecoder decodeObjectForKey:kEDUWorksListInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDUWorksListInfoSort];
    [aCoder encodeObject:_sfrom forKey:kEDUWorksListInfoSfrom];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUWorksListInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUWorksListInfoAddTimeShow];
    [aCoder encodeObject:_title forKey:kEDUWorksListInfoTitle];
    [aCoder encodeObject:_descr forKey:kEDUWorksListInfoDescr];
    [aCoder encodeObject:_thumb forKey:kEDUWorksListInfoThumb];
    [aCoder encodeDouble:_duration forKey:kEDUWorksListInfoDuration];
    [aCoder encodeObject:_timeShow forKey:kEDUWorksListInfoTimeShow];
    [aCoder encodeObject:_memo forKey:kEDUWorksListInfoMemo];
    [aCoder encodeObject:_url forKey:kEDUWorksListInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUWorksListInfo *copy = [[EDUWorksListInfo alloc] init];
    
    if (copy) {

        copy.sort = self.sort;
        copy.sfrom = [self.sfrom copyWithZone:zone];
        copy.infoIdentifier = self.infoIdentifier;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.duration = self.duration;
        copy.timeShow = [self.timeShow copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
