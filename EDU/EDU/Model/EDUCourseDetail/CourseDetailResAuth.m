//
//  CourseDetailResAuth.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailResAuth.h"


NSString *const kCourseDetailResAuthId = @"id";
NSString *const kCourseDetailResAuthName = @"name";


@interface CourseDetailResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetailResAuth

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
            self.resAuthIdentifier = [[self objectOrNilForKey:kCourseDetailResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kCourseDetailResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kCourseDetailResAuthId];
    [mutableDict setValue:self.name forKey:kCourseDetailResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kCourseDetailResAuthId];
    self.name = [aDecoder decodeObjectForKey:kCourseDetailResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kCourseDetailResAuthId];
    [aCoder encodeObject:_name forKey:kCourseDetailResAuthName];
}

- (id)copyWithZone:(NSZone *)zone {
    CourseDetailResAuth *copy = [[CourseDetailResAuth alloc] init];
    
    
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
