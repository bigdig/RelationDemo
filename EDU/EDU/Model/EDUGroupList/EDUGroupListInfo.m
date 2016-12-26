//
//  EDUGroupListInfo.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupListInfo.h"


NSString *const kEDUGroupListInfoTotalTimeShow = @"totalTimeShow";
NSString *const kEDUGroupListInfoId = @"id";
NSString *const kEDUGroupListInfoTitle = @"title";
NSString *const kEDUGroupListInfoTitlePic = @"titlePic";
NSString *const kEDUGroupListInfoDescr = @"descr";
NSString *const kEDUGroupListInfoCnt = @"cnt";


@interface EDUGroupListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupListInfo

@synthesize totalTimeShow = _totalTimeShow;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize title = _title;
@synthesize titlePic = _titlePic;
@synthesize descr = _descr;
@synthesize cnt = _cnt;


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
            self.totalTimeShow = [self objectOrNilForKey:kEDUGroupListInfoTotalTimeShow fromDictionary:dict];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUGroupListInfoId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kEDUGroupListInfoTitle fromDictionary:dict];
            self.titlePic = [self objectOrNilForKey:kEDUGroupListInfoTitlePic fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUGroupListInfoDescr fromDictionary:dict];
            self.cnt = [[self objectOrNilForKey:kEDUGroupListInfoCnt fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalTimeShow forKey:kEDUGroupListInfoTotalTimeShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUGroupListInfoId];
    [mutableDict setValue:self.title forKey:kEDUGroupListInfoTitle];
    [mutableDict setValue:self.titlePic forKey:kEDUGroupListInfoTitlePic];
    [mutableDict setValue:self.descr forKey:kEDUGroupListInfoDescr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kEDUGroupListInfoCnt];

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

    self.totalTimeShow = [aDecoder decodeObjectForKey:kEDUGroupListInfoTotalTimeShow];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupListInfoId];
    self.title = [aDecoder decodeObjectForKey:kEDUGroupListInfoTitle];
    self.titlePic = [aDecoder decodeObjectForKey:kEDUGroupListInfoTitlePic];
    self.descr = [aDecoder decodeObjectForKey:kEDUGroupListInfoDescr];
    self.cnt = [aDecoder decodeDoubleForKey:kEDUGroupListInfoCnt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalTimeShow forKey:kEDUGroupListInfoTotalTimeShow];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUGroupListInfoId];
    [aCoder encodeObject:_title forKey:kEDUGroupListInfoTitle];
    [aCoder encodeObject:_titlePic forKey:kEDUGroupListInfoTitlePic];
    [aCoder encodeObject:_descr forKey:kEDUGroupListInfoDescr];
    [aCoder encodeDouble:_cnt forKey:kEDUGroupListInfoCnt];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupListInfo *copy = [[EDUGroupListInfo alloc] init];
    
    if (copy) {

        copy.totalTimeShow = [self.totalTimeShow copyWithZone:zone];
        copy.infoIdentifier = self.infoIdentifier;
        copy.title = [self.title copyWithZone:zone];
        copy.titlePic = [self.titlePic copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.cnt = self.cnt;
    }
    
    return copy;
}


@end
