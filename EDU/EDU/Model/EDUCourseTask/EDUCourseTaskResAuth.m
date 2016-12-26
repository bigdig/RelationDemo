//
//  EDUCourseTaskResAuth.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseTaskResAuth.h"


NSString *const kEDUCourseTaskResAuthId = @"id";
NSString *const kEDUCourseTaskResAuthName = @"name";


@interface EDUCourseTaskResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseTaskResAuth

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
            self.resAuthIdentifier = [[self objectOrNilForKey:kEDUCourseTaskResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUCourseTaskResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kEDUCourseTaskResAuthId];
    [mutableDict setValue:self.name forKey:kEDUCourseTaskResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseTaskResAuthId];
    self.name = [aDecoder decodeObjectForKey:kEDUCourseTaskResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kEDUCourseTaskResAuthId];
    [aCoder encodeObject:_name forKey:kEDUCourseTaskResAuthName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseTaskResAuth *copy = [[EDUCourseTaskResAuth alloc] init];
    
    
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
