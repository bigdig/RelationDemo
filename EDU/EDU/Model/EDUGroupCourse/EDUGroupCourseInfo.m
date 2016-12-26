//
//  EDUGroupCourseInfo.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupCourseInfo.h"
#import "EDUGroupCourseGroup.h"
#import "EDUGroupCourseCourseList.h"


NSString *const kEDUGroupCourseInfoGroup = @"group";
NSString *const kEDUGroupCourseInfoCourseList = @"courseList";


@interface EDUGroupCourseInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseInfo

@synthesize group = _group;
@synthesize courseList = _courseList;


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
            self.group = [EDUGroupCourseGroup modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseInfoGroup]];
    NSObject *receivedEDUGroupCourseCourseList = [dict objectForKey:kEDUGroupCourseInfoCourseList];
    NSMutableArray *parsedEDUGroupCourseCourseList = [NSMutableArray array];
    if ([receivedEDUGroupCourseCourseList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUGroupCourseCourseList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUGroupCourseCourseList addObject:[EDUGroupCourseCourseList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUGroupCourseCourseList isKindOfClass:[NSDictionary class]]) {
       [parsedEDUGroupCourseCourseList addObject:[EDUGroupCourseCourseList modelObjectWithDictionary:(NSDictionary *)receivedEDUGroupCourseCourseList]];
    }

    self.courseList = [NSArray arrayWithArray:parsedEDUGroupCourseCourseList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.group dictionaryRepresentation] forKey:kEDUGroupCourseInfoGroup];
    NSMutableArray *tempArrayForCourseList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.courseList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourseList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourseList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourseList] forKey:kEDUGroupCourseInfoCourseList];

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

    self.group = [aDecoder decodeObjectForKey:kEDUGroupCourseInfoGroup];
    self.courseList = [aDecoder decodeObjectForKey:kEDUGroupCourseInfoCourseList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_group forKey:kEDUGroupCourseInfoGroup];
    [aCoder encodeObject:_courseList forKey:kEDUGroupCourseInfoCourseList];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupCourseInfo *copy = [[EDUGroupCourseInfo alloc] init];
    
    if (copy) {

        copy.group = [self.group copyWithZone:zone];
        copy.courseList = [self.courseList copyWithZone:zone];
    }
    
    return copy;
}


@end
