//
//  EDUResGroupListInfo.m
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUResGroupListInfo.h"


NSString *const kEDUResGroupListInfoIcon = @"icon";
NSString *const kEDUResGroupListInfoSort = @"sort";
NSString *const kEDUResGroupListInfoId = @"id";
NSString *const kEDUResGroupListInfoTitle = @"title";
NSString *const kEDUResGroupListInfoDescr = @"descr";
NSString *const kEDUResGroupListInfoTitlePic = @"titlePic";
NSString *const kEDUResGroupListInfoCnt = @"cnt";
NSString *const kEDUResGroupListInfoTotalTimeShow = @"totalTimeShow";
NSString *const kEDUResGroupListInfoLongTitle = @"longTitle";


@interface EDUResGroupListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUResGroupListInfo

@synthesize icon = _icon;
@synthesize sort = _sort;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize title = _title;
@synthesize descr = _descr;
@synthesize titlePic = _titlePic;
@synthesize cnt = _cnt;
@synthesize totalTimeShow = _totalTimeShow;
@synthesize longTitle = _longTitle;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.icon = [self objectOrNilForKey:kEDUResGroupListInfoIcon fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUResGroupListInfoSort fromDictionary:dict] doubleValue];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUResGroupListInfoId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kEDUResGroupListInfoTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUResGroupListInfoDescr fromDictionary:dict];
            self.titlePic = [self objectOrNilForKey:kEDUResGroupListInfoTitlePic fromDictionary:dict];
            self.cnt = [[self objectOrNilForKey:kEDUResGroupListInfoCnt fromDictionary:dict] doubleValue];
            self.totalTimeShow = [self objectOrNilForKey:kEDUResGroupListInfoTotalTimeShow fromDictionary:dict];
            self.longTitle = [self objectOrNilForKey:kEDUResGroupListInfoLongTitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icon forKey:kEDUResGroupListInfoIcon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUResGroupListInfoSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUResGroupListInfoId];
    [mutableDict setValue:self.title forKey:kEDUResGroupListInfoTitle];
    [mutableDict setValue:self.descr forKey:kEDUResGroupListInfoDescr];
    [mutableDict setValue:self.titlePic forKey:kEDUResGroupListInfoTitlePic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kEDUResGroupListInfoCnt];
    [mutableDict setValue:self.totalTimeShow forKey:kEDUResGroupListInfoTotalTimeShow];
    [mutableDict setValue:self.longTitle forKey:kEDUResGroupListInfoLongTitle];

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

    self.icon = [aDecoder decodeObjectForKey:kEDUResGroupListInfoIcon];
    self.sort = [aDecoder decodeDoubleForKey:kEDUResGroupListInfoSort];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUResGroupListInfoId];
    self.title = [aDecoder decodeObjectForKey:kEDUResGroupListInfoTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUResGroupListInfoDescr];
    self.titlePic = [aDecoder decodeObjectForKey:kEDUResGroupListInfoTitlePic];
    self.cnt = [aDecoder decodeDoubleForKey:kEDUResGroupListInfoCnt];
    self.totalTimeShow = [aDecoder decodeObjectForKey:kEDUResGroupListInfoTotalTimeShow];
    self.longTitle = [aDecoder decodeObjectForKey:kEDUResGroupListInfoLongTitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icon forKey:kEDUResGroupListInfoIcon];
    [aCoder encodeDouble:_sort forKey:kEDUResGroupListInfoSort];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUResGroupListInfoId];
    [aCoder encodeObject:_title forKey:kEDUResGroupListInfoTitle];
    [aCoder encodeObject:_descr forKey:kEDUResGroupListInfoDescr];
    [aCoder encodeObject:_titlePic forKey:kEDUResGroupListInfoTitlePic];
    [aCoder encodeDouble:_cnt forKey:kEDUResGroupListInfoCnt];
    [aCoder encodeObject:_totalTimeShow forKey:kEDUResGroupListInfoTotalTimeShow];
    [aCoder encodeObject:_longTitle forKey:kEDUResGroupListInfoLongTitle];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUResGroupListInfo *copy = [[EDUResGroupListInfo alloc] init];
    
    
    
    if (copy) {

        copy.icon = [self.icon copyWithZone:zone];
        copy.sort = self.sort;
        copy.infoIdentifier = self.infoIdentifier;
        copy.title = [self.title copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.titlePic = [self.titlePic copyWithZone:zone];
        copy.cnt = self.cnt;
        copy.totalTimeShow = [self.totalTimeShow copyWithZone:zone];
        copy.longTitle = [self.longTitle copyWithZone:zone];
    }
    
    return copy;
}


@end
