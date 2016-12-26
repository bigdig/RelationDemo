//
//  EDUHistoryListSacRole.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListSacRole.h"


NSString *const kEDUHistoryListSacRoleId = @"id";
NSString *const kEDUHistoryListSacRoleName = @"name";


@interface EDUHistoryListSacRole ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListSacRole

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
            self.sacRoleIdentifier = [[self objectOrNilForKey:kEDUHistoryListSacRoleId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUHistoryListSacRoleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacRoleIdentifier] forKey:kEDUHistoryListSacRoleId];
    [mutableDict setValue:self.name forKey:kEDUHistoryListSacRoleName];

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

    self.sacRoleIdentifier = [aDecoder decodeDoubleForKey:kEDUHistoryListSacRoleId];
    self.name = [aDecoder decodeObjectForKey:kEDUHistoryListSacRoleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacRoleIdentifier forKey:kEDUHistoryListSacRoleId];
    [aCoder encodeObject:_name forKey:kEDUHistoryListSacRoleName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListSacRole *copy = [[EDUHistoryListSacRole alloc] init];
    
    
    
    if (copy) {

        copy.sacRoleIdentifier = self.sacRoleIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
