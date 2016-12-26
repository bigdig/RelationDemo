//
//  EDUCourseCommentSacRole.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentSacRole.h"


NSString *const kEDUCourseCommentSacRoleId = @"id";
NSString *const kEDUCourseCommentSacRoleName = @"name";


@interface EDUCourseCommentSacRole ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentSacRole

@synthesize sacRoleIdentifier = _sacRoleIdentifier;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sacRoleIdentifier = [[self objectOrNilForKey:kEDUCourseCommentSacRoleId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUCourseCommentSacRoleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacRoleIdentifier] forKey:kEDUCourseCommentSacRoleId];
    [mutableDict setValue:self.name forKey:kEDUCourseCommentSacRoleName];

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

    self.sacRoleIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseCommentSacRoleId];
    self.name = [aDecoder decodeObjectForKey:kEDUCourseCommentSacRoleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacRoleIdentifier forKey:kEDUCourseCommentSacRoleId];
    [aCoder encodeObject:_name forKey:kEDUCourseCommentSacRoleName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentSacRole *copy = [[EDUCourseCommentSacRole alloc] init];
    
    
    
    if (copy) {

        copy.sacRoleIdentifier = self.sacRoleIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
