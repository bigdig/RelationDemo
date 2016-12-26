//
//  EDUGroupCourseGroup.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupCourseGroup.h"


NSString *const kEDUGroupCourseGroupTotalTimeShow = @"totalTimeShow";
NSString *const kEDUGroupCourseGroupId = @"id";
NSString *const kEDUGroupCourseGroupTitle = @"title";
NSString *const kEDUGroupCourseGroupTitlePic = @"titlePic";
NSString *const kEDUGroupCourseGroupDescr = @"descr";
NSString *const kEDUGroupCourseGroupCnt = @"cnt";


@interface EDUGroupCourseGroup ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseGroup

@synthesize totalTimeShow = _totalTimeShow;
@synthesize groupIdentifier = _groupIdentifier;
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
            self.totalTimeShow = [self objectOrNilForKey:kEDUGroupCourseGroupTotalTimeShow fromDictionary:dict];
            self.groupIdentifier = [[self objectOrNilForKey:kEDUGroupCourseGroupId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kEDUGroupCourseGroupTitle fromDictionary:dict];
            self.titlePic = [self objectOrNilForKey:kEDUGroupCourseGroupTitlePic fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUGroupCourseGroupDescr fromDictionary:dict];
            self.cnt = [[self objectOrNilForKey:kEDUGroupCourseGroupCnt fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalTimeShow forKey:kEDUGroupCourseGroupTotalTimeShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupIdentifier] forKey:kEDUGroupCourseGroupId];
    [mutableDict setValue:self.title forKey:kEDUGroupCourseGroupTitle];
    [mutableDict setValue:self.titlePic forKey:kEDUGroupCourseGroupTitlePic];
    [mutableDict setValue:self.descr forKey:kEDUGroupCourseGroupDescr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kEDUGroupCourseGroupCnt];

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

    self.totalTimeShow = [aDecoder decodeObjectForKey:kEDUGroupCourseGroupTotalTimeShow];
    self.groupIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseGroupId];
    self.title = [aDecoder decodeObjectForKey:kEDUGroupCourseGroupTitle];
    self.titlePic = [aDecoder decodeObjectForKey:kEDUGroupCourseGroupTitlePic];
    self.descr = [aDecoder decodeObjectForKey:kEDUGroupCourseGroupDescr];
    self.cnt = [aDecoder decodeDoubleForKey:kEDUGroupCourseGroupCnt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalTimeShow forKey:kEDUGroupCourseGroupTotalTimeShow];
    [aCoder encodeDouble:_groupIdentifier forKey:kEDUGroupCourseGroupId];
    [aCoder encodeObject:_title forKey:kEDUGroupCourseGroupTitle];
    [aCoder encodeObject:_titlePic forKey:kEDUGroupCourseGroupTitlePic];
    [aCoder encodeObject:_descr forKey:kEDUGroupCourseGroupDescr];
    [aCoder encodeDouble:_cnt forKey:kEDUGroupCourseGroupCnt];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupCourseGroup *copy = [[EDUGroupCourseGroup alloc] init];
    
    if (copy) {

        copy.totalTimeShow = [self.totalTimeShow copyWithZone:zone];
        copy.groupIdentifier = self.groupIdentifier;
        copy.title = [self.title copyWithZone:zone];
        copy.titlePic = [self.titlePic copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.cnt = self.cnt;
    }
    
    return copy;
}


@end
