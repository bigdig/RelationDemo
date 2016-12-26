//
//  EDUCourseCommentResAuth.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentResAuth.h"


NSString *const kEDUCourseCommentResAuthId = @"id";
NSString *const kEDUCourseCommentResAuthName = @"name";


@interface EDUCourseCommentResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentResAuth

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
            self.resAuthIdentifier = [[self objectOrNilForKey:kEDUCourseCommentResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUCourseCommentResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kEDUCourseCommentResAuthId];
    [mutableDict setValue:self.name forKey:kEDUCourseCommentResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseCommentResAuthId];
    self.name = [aDecoder decodeObjectForKey:kEDUCourseCommentResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kEDUCourseCommentResAuthId];
    [aCoder encodeObject:_name forKey:kEDUCourseCommentResAuthName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentResAuth *copy = [[EDUCourseCommentResAuth alloc] init];
    
    
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
