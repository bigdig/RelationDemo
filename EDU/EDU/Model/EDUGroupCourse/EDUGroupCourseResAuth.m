//
//  EDUGroupCourseResAuth.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupCourseResAuth.h"


NSString *const kEDUGroupCourseResAuthId = @"id";
NSString *const kEDUGroupCourseResAuthName = @"name";


@interface EDUGroupCourseResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseResAuth

@synthesize resAuthIdentifier = _resAuthIdentifier;
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
            self.resAuthIdentifier = [[self objectOrNilForKey:kEDUGroupCourseResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUGroupCourseResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kEDUGroupCourseResAuthId];
    [mutableDict setValue:self.name forKey:kEDUGroupCourseResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseResAuthId];
    self.name = [aDecoder decodeObjectForKey:kEDUGroupCourseResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kEDUGroupCourseResAuthId];
    [aCoder encodeObject:_name forKey:kEDUGroupCourseResAuthName];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupCourseResAuth *copy = [[EDUGroupCourseResAuth alloc] init];
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
