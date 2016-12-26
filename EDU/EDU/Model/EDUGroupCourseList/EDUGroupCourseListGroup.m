//
//  EDUGroupCourseListGroup.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListGroup.h"


NSString *const kEDUGroupCourseListGroupIcon = @"icon";
NSString *const kEDUGroupCourseListGroupSort = @"sort";
NSString *const kEDUGroupCourseListGroupId = @"id";
NSString *const kEDUGroupCourseListGroupTitle = @"title";
NSString *const kEDUGroupCourseListGroupDescr = @"descr";
NSString *const kEDUGroupCourseListGroupTitlePic = @"titlePic";
NSString *const kEDUGroupCourseListGroupCnt = @"cnt";
NSString *const kEDUGroupCourseListGroupTotalTimeShow = @"totalTimeShow";
NSString *const kEDUGroupCourseListGroupLongTitle = @"longTitle";


@interface EDUGroupCourseListGroup ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListGroup

@synthesize icon = _icon;
@synthesize sort = _sort;
@synthesize groupIdentifier = _groupIdentifier;
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
            self.icon = [self objectOrNilForKey:kEDUGroupCourseListGroupIcon fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUGroupCourseListGroupSort fromDictionary:dict] doubleValue];
            self.groupIdentifier = [[self objectOrNilForKey:kEDUGroupCourseListGroupId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kEDUGroupCourseListGroupTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUGroupCourseListGroupDescr fromDictionary:dict];
            self.titlePic = [self objectOrNilForKey:kEDUGroupCourseListGroupTitlePic fromDictionary:dict];
            self.cnt = [[self objectOrNilForKey:kEDUGroupCourseListGroupCnt fromDictionary:dict] doubleValue];
            self.totalTimeShow = [self objectOrNilForKey:kEDUGroupCourseListGroupTotalTimeShow fromDictionary:dict];
            self.longTitle = [self objectOrNilForKey:kEDUGroupCourseListGroupLongTitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icon forKey:kEDUGroupCourseListGroupIcon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUGroupCourseListGroupSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupIdentifier] forKey:kEDUGroupCourseListGroupId];
    [mutableDict setValue:self.title forKey:kEDUGroupCourseListGroupTitle];
    [mutableDict setValue:self.descr forKey:kEDUGroupCourseListGroupDescr];
    [mutableDict setValue:self.titlePic forKey:kEDUGroupCourseListGroupTitlePic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kEDUGroupCourseListGroupCnt];
    [mutableDict setValue:self.totalTimeShow forKey:kEDUGroupCourseListGroupTotalTimeShow];
    [mutableDict setValue:self.longTitle forKey:kEDUGroupCourseListGroupLongTitle];

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

    self.icon = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupIcon];
    self.sort = [aDecoder decodeDoubleForKey:kEDUGroupCourseListGroupSort];
    self.groupIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseListGroupId];
    self.title = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupDescr];
    self.titlePic = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupTitlePic];
    self.cnt = [aDecoder decodeDoubleForKey:kEDUGroupCourseListGroupCnt];
    self.totalTimeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupTotalTimeShow];
    self.longTitle = [aDecoder decodeObjectForKey:kEDUGroupCourseListGroupLongTitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icon forKey:kEDUGroupCourseListGroupIcon];
    [aCoder encodeDouble:_sort forKey:kEDUGroupCourseListGroupSort];
    [aCoder encodeDouble:_groupIdentifier forKey:kEDUGroupCourseListGroupId];
    [aCoder encodeObject:_title forKey:kEDUGroupCourseListGroupTitle];
    [aCoder encodeObject:_descr forKey:kEDUGroupCourseListGroupDescr];
    [aCoder encodeObject:_titlePic forKey:kEDUGroupCourseListGroupTitlePic];
    [aCoder encodeDouble:_cnt forKey:kEDUGroupCourseListGroupCnt];
    [aCoder encodeObject:_totalTimeShow forKey:kEDUGroupCourseListGroupTotalTimeShow];
    [aCoder encodeObject:_longTitle forKey:kEDUGroupCourseListGroupLongTitle];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListGroup *copy = [[EDUGroupCourseListGroup alloc] init];
    
    
    
    if (copy) {

        copy.icon = [self.icon copyWithZone:zone];
        copy.sort = self.sort;
        copy.groupIdentifier = self.groupIdentifier;
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
