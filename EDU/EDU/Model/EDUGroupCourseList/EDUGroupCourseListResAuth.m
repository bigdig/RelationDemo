//
//  EDUGroupCourseListResAuth.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListResAuth.h"


NSString *const kEDUGroupCourseListResAuthId = @"id";
NSString *const kEDUGroupCourseListResAuthName = @"name";


@interface EDUGroupCourseListResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListResAuth

@synthesize resAuthIdentifier = _resAuthIdentifier;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resAuthIdentifier = [[self objectOrNilForKey:kEDUGroupCourseListResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUGroupCourseListResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kEDUGroupCourseListResAuthId];
    [mutableDict setValue:self.name forKey:kEDUGroupCourseListResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kEDUGroupCourseListResAuthId];
    self.name = [aDecoder decodeObjectForKey:kEDUGroupCourseListResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kEDUGroupCourseListResAuthId];
    [aCoder encodeObject:_name forKey:kEDUGroupCourseListResAuthName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListResAuth *copy = [[EDUGroupCourseListResAuth alloc] init];
    
    
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
