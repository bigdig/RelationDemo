//
//  EDUCourseListInfo.m
//
//  Created by xingguo ren on 16/9/1
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUCourseListInfo.h"
#import "EDUCourseListList.h"


NSString *const kEDUCourseListInfoList = @"list";


@interface EDUCourseListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseListInfo

@synthesize list = _list;


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
    NSObject *receivedEDUCourseListList = [dict objectForKey:kEDUCourseListInfoList];
    NSMutableArray *parsedEDUCourseListList = [NSMutableArray array];
    if ([receivedEDUCourseListList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUCourseListList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUCourseListList addObject:[EDUCourseListList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUCourseListList isKindOfClass:[NSDictionary class]]) {
       [parsedEDUCourseListList addObject:[EDUCourseListList modelObjectWithDictionary:(NSDictionary *)receivedEDUCourseListList]];
    }

    self.list = [NSArray arrayWithArray:parsedEDUCourseListList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kEDUCourseListInfoList];

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

    self.list = [aDecoder decodeObjectForKey:kEDUCourseListInfoList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kEDUCourseListInfoList];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUCourseListInfo *copy = [[EDUCourseListInfo alloc] init];
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
