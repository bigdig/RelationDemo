//
//  EDUTagListInternalBaseClass1.m
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUTagListInternalBaseClass1.h"


NSString *const kEDUTagListInternalBaseClass1Id = @"id";
NSString *const kEDUTagListInternalBaseClass1Name = @"name";
NSString *const kEDUTagListInternalBaseClass1GroupId = @"groupId";


@interface EDUTagListInternalBaseClass1 ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUTagListInternalBaseClass1

@synthesize internalBaseClass1Identifier = _internalBaseClass1Identifier;
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
            self.internalBaseClass1Identifier = [[self objectOrNilForKey:kEDUTagListInternalBaseClass1Id fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUTagListInternalBaseClass1Name fromDictionary:dict];
            self.groupId = [[self objectOrNilForKey:kEDUTagListInternalBaseClass1GroupId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClass1Identifier] forKey:kEDUTagListInternalBaseClass1Id];
    [mutableDict setValue:self.name forKey:kEDUTagListInternalBaseClass1Name];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupId] forKey:kEDUTagListInternalBaseClass1GroupId];

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

    self.internalBaseClass1Identifier = [aDecoder decodeDoubleForKey:kEDUTagListInternalBaseClass1Id];
    self.name = [aDecoder decodeObjectForKey:kEDUTagListInternalBaseClass1Name];
    self.groupId = [aDecoder decodeDoubleForKey:kEDUTagListInternalBaseClass1GroupId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClass1Identifier forKey:kEDUTagListInternalBaseClass1Id];
    [aCoder encodeObject:_name forKey:kEDUTagListInternalBaseClass1Name];
    [aCoder encodeDouble:_groupId forKey:kEDUTagListInternalBaseClass1GroupId];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUTagListInternalBaseClass1 *copy = [[EDUTagListInternalBaseClass1 alloc] init];
    
    
    
    if (copy) {

        copy.internalBaseClass1Identifier = self.internalBaseClass1Identifier;
        copy.name = [self.name copyWithZone:zone];
        copy.groupId = self.groupId;
    }
    
    return copy;
}


@end
