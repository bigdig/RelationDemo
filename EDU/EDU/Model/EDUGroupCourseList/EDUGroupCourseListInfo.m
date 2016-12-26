//
//  EDUGroupCourseListInfo.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListInfo.h"
#import "EDUGroupCourseListGroup.h"
#import "EDUGroupCourseListCourseList.h"


NSString *const kEDUGroupCourseListInfoGroup = @"group";
NSString *const kEDUGroupCourseListInfoCourseList = @"courseList";


@interface EDUGroupCourseListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListInfo

@synthesize group = _group;
@synthesize courseList = _courseList;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.group = [EDUGroupCourseListGroup modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseListInfoGroup]];
    NSObject *receivedEDUGroupCourseListCourseList = [dict objectForKey:kEDUGroupCourseListInfoCourseList];
    NSMutableArray *parsedEDUGroupCourseListCourseList = [NSMutableArray array];
    
    if ([receivedEDUGroupCourseListCourseList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUGroupCourseListCourseList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUGroupCourseListCourseList addObject:[EDUGroupCourseListCourseList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUGroupCourseListCourseList isKindOfClass:[NSDictionary class]]) {
       [parsedEDUGroupCourseListCourseList addObject:[EDUGroupCourseListCourseList modelObjectWithDictionary:(NSDictionary *)receivedEDUGroupCourseListCourseList]];
    }

    self.courseList = [NSArray arrayWithArray:parsedEDUGroupCourseListCourseList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.group dictionaryRepresentation] forKey:kEDUGroupCourseListInfoGroup];
    NSMutableArray *tempArrayForCourseList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.courseList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourseList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourseList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourseList] forKey:kEDUGroupCourseListInfoCourseList];

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

    self.group = [aDecoder decodeObjectForKey:kEDUGroupCourseListInfoGroup];
    self.courseList = [aDecoder decodeObjectForKey:kEDUGroupCourseListInfoCourseList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_group forKey:kEDUGroupCourseListInfoGroup];
    [aCoder encodeObject:_courseList forKey:kEDUGroupCourseListInfoCourseList];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListInfo *copy = [[EDUGroupCourseListInfo alloc] init];
    
    
    
    if (copy) {

        copy.group = [self.group copyWithZone:zone];
        copy.courseList = [self.courseList copyWithZone:zone];
    }
    
    return copy;
}


@end
