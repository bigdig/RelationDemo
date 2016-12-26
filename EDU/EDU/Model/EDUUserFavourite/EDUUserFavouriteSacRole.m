//
//  EDUUserFavouriteSacRole.m
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUUserFavouriteSacRole.h"


NSString *const kEDUUserFavouriteSacRoleId = @"id";
NSString *const kEDUUserFavouriteSacRoleName = @"name";


@interface EDUUserFavouriteSacRole ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUUserFavouriteSacRole

@synthesize sacRoleIdentifier = _sacRoleIdentifier;
@synthesize name = _name;


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
            self.sacRoleIdentifier = [[self objectOrNilForKey:kEDUUserFavouriteSacRoleId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUUserFavouriteSacRoleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacRoleIdentifier] forKey:kEDUUserFavouriteSacRoleId];
    [mutableDict setValue:self.name forKey:kEDUUserFavouriteSacRoleName];

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

    self.sacRoleIdentifier = [aDecoder decodeDoubleForKey:kEDUUserFavouriteSacRoleId];
    self.name = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacRoleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacRoleIdentifier forKey:kEDUUserFavouriteSacRoleId];
    [aCoder encodeObject:_name forKey:kEDUUserFavouriteSacRoleName];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUUserFavouriteSacRole *copy = [[EDUUserFavouriteSacRole alloc] init];
    
    if (copy) {

        copy.sacRoleIdentifier = self.sacRoleIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
