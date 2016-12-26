//
//  EDUGroupCourseListResTags.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListResTags.h"


NSString *const kEDUGroupCourseListResTagsId = @"id";
NSString *const kEDUGroupCourseListResTagsName = @"name";
NSString *const kEDUGroupCourseListResTagsGroupId = @"groupId";


@interface EDUGroupCourseListResTags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListResTags

@synthesize resTagsIdentifier = _resTagsIdentifier;
@synthesize name = _name;
@synthesize groupId = _groupId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resTagsIdentifier = [[self objectOrNilForKey:kEDUGroupCourseListResTagsId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUGroupCourseListResTagsName fromDictionary:dict];
            self.groupId = [[self objectOrNilForKey:kEDUGroupCourseListResTagsGroupId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resTagsIdentifier] forKey:kEDUGroupCourseListResTagsId];
    [mutableDict setValue:self.name forKey:kEDUGroupCourseListResTagsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupId] forKey:kEDUGroupCourseListResTagsGroupId];

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

    self.resTagsIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseListResTagsId];
    self.name = [aDecoder decodeObjectForKey:kEDUGroupCourseListResTagsName];
    self.groupId = [aDecoder decodeDoubleForKey:kEDUGroupCourseListResTagsGroupId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resTagsIdentifier forKey:kEDUGroupCourseListResTagsId];
    [aCoder encodeObject:_name forKey:kEDUGroupCourseListResTagsName];
    [aCoder encodeDouble:_groupId forKey:kEDUGroupCourseListResTagsGroupId];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListResTags *copy = [[EDUGroupCourseListResTags alloc] init];
    
    
    
    if (copy) {

        copy.resTagsIdentifier = self.resTagsIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.groupId = self.groupId;
    }
    
    return copy;
}


@end
