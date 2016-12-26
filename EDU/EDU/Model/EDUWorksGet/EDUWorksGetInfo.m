//
//  EDUWorksGetInfo.m
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUWorksGetInfo.h"


NSString *const kEDUWorksGetInfoSort = @"sort";
NSString *const kEDUWorksGetInfoSfrom = @"sfrom";
NSString *const kEDUWorksGetInfoId = @"id";
NSString *const kEDUWorksGetInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUWorksGetInfoTitle = @"title";
NSString *const kEDUWorksGetInfoDescr = @"descr";
NSString *const kEDUWorksGetInfoThumb = @"thumb";
NSString *const kEDUWorksGetInfoDuration = @"duration";
NSString *const kEDUWorksGetInfoTimeShow = @"timeShow";
NSString *const kEDUWorksGetInfoMemo = @"memo";
NSString *const kEDUWorksGetInfoUrl = @"url";


@interface EDUWorksGetInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUWorksGetInfo

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
            self.sort = [[self objectOrNilForKey:kEDUWorksGetInfoSort fromDictionary:dict] doubleValue];
            self.sfrom = [self objectOrNilForKey:kEDUWorksGetInfoSfrom fromDictionary:dict];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUWorksGetInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUWorksGetInfoAddTimeShow fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUWorksGetInfoTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUWorksGetInfoDescr fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kEDUWorksGetInfoThumb fromDictionary:dict];
            self.duration = [[self objectOrNilForKey:kEDUWorksGetInfoDuration fromDictionary:dict] doubleValue];
            self.timeShow = [self objectOrNilForKey:kEDUWorksGetInfoTimeShow fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kEDUWorksGetInfoMemo fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUWorksGetInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUWorksGetInfoSort];
    [mutableDict setValue:self.sfrom forKey:kEDUWorksGetInfoSfrom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUWorksGetInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUWorksGetInfoAddTimeShow];
    [mutableDict setValue:self.title forKey:kEDUWorksGetInfoTitle];
    [mutableDict setValue:self.descr forKey:kEDUWorksGetInfoDescr];
    [mutableDict setValue:self.thumb forKey:kEDUWorksGetInfoThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kEDUWorksGetInfoDuration];
    [mutableDict setValue:self.timeShow forKey:kEDUWorksGetInfoTimeShow];
    [mutableDict setValue:self.memo forKey:kEDUWorksGetInfoMemo];
    [mutableDict setValue:self.url forKey:kEDUWorksGetInfoUrl];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDUWorksGetInfoSort];
    self.sfrom = [aDecoder decodeObjectForKey:kEDUWorksGetInfoSfrom];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUWorksGetInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUWorksGetInfoAddTimeShow];
    self.title = [aDecoder decodeObjectForKey:kEDUWorksGetInfoTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUWorksGetInfoDescr];
    self.thumb = [aDecoder decodeObjectForKey:kEDUWorksGetInfoThumb];
    self.duration = [aDecoder decodeDoubleForKey:kEDUWorksGetInfoDuration];
    self.timeShow = [aDecoder decodeObjectForKey:kEDUWorksGetInfoTimeShow];
    self.memo = [aDecoder decodeObjectForKey:kEDUWorksGetInfoMemo];
    self.url = [aDecoder decodeObjectForKey:kEDUWorksGetInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDUWorksGetInfoSort];
    [aCoder encodeObject:_sfrom forKey:kEDUWorksGetInfoSfrom];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUWorksGetInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUWorksGetInfoAddTimeShow];
    [aCoder encodeObject:_title forKey:kEDUWorksGetInfoTitle];
    [aCoder encodeObject:_descr forKey:kEDUWorksGetInfoDescr];
    [aCoder encodeObject:_thumb forKey:kEDUWorksGetInfoThumb];
    [aCoder encodeDouble:_duration forKey:kEDUWorksGetInfoDuration];
    [aCoder encodeObject:_timeShow forKey:kEDUWorksGetInfoTimeShow];
    [aCoder encodeObject:_memo forKey:kEDUWorksGetInfoMemo];
    [aCoder encodeObject:_url forKey:kEDUWorksGetInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUWorksGetInfo *copy = [[EDUWorksGetInfo alloc] init];
    
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
