//
//  EDUTagListInternalBaseClass2.m
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUTagListInternalBaseClass2.h"


NSString *const kEDUTagListInternalBaseClass2Id = @"id";
NSString *const kEDUTagListInternalBaseClass2Name = @"name";
NSString *const kEDUTagListInternalBaseClass2GroupId = @"groupId";


@interface EDUTagListInternalBaseClass2 ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUTagListInternalBaseClass2

@synthesize internalBaseClass2Identifier = _internalBaseClass2Identifier;
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
            self.internalBaseClass2Identifier = [[self objectOrNilForKey:kEDUTagListInternalBaseClass2Id fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUTagListInternalBaseClass2Name fromDictionary:dict];
            self.groupId = [[self objectOrNilForKey:kEDUTagListInternalBaseClass2GroupId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClass2Identifier] forKey:kEDUTagListInternalBaseClass2Id];
    [mutableDict setValue:self.name forKey:kEDUTagListInternalBaseClass2Name];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupId] forKey:kEDUTagListInternalBaseClass2GroupId];

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

    self.internalBaseClass2Identifier = [aDecoder decodeDoubleForKey:kEDUTagListInternalBaseClass2Id];
    self.name = [aDecoder decodeObjectForKey:kEDUTagListInternalBaseClass2Name];
    self.groupId = [aDecoder decodeDoubleForKey:kEDUTagListInternalBaseClass2GroupId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClass2Identifier forKey:kEDUTagListInternalBaseClass2Id];
    [aCoder encodeObject:_name forKey:kEDUTagListInternalBaseClass2Name];
    [aCoder encodeDouble:_groupId forKey:kEDUTagListInternalBaseClass2GroupId];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUTagListInternalBaseClass2 *copy = [[EDUTagListInternalBaseClass2 alloc] init];
    
    
    
    if (copy) {

        copy.internalBaseClass2Identifier = self.internalBaseClass2Identifier;
        copy.name = [self.name copyWithZone:zone];
        copy.groupId = self.groupId;
    }
    
    return copy;
}


@end
