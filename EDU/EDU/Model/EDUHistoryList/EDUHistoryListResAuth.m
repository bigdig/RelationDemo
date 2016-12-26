//
//  EDUHistoryListResAuth.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListResAuth.h"


NSString *const kEDUHistoryListResAuthId = @"id";
NSString *const kEDUHistoryListResAuthName = @"name";


@interface EDUHistoryListResAuth ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListResAuth

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
            self.resAuthIdentifier = [[self objectOrNilForKey:kEDUHistoryListResAuthId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kEDUHistoryListResAuthName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resAuthIdentifier] forKey:kEDUHistoryListResAuthId];
    [mutableDict setValue:self.name forKey:kEDUHistoryListResAuthName];

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

    self.resAuthIdentifier = [aDecoder decodeDoubleForKey:kEDUHistoryListResAuthId];
    self.name = [aDecoder decodeObjectForKey:kEDUHistoryListResAuthName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resAuthIdentifier forKey:kEDUHistoryListResAuthId];
    [aCoder encodeObject:_name forKey:kEDUHistoryListResAuthName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListResAuth *copy = [[EDUHistoryListResAuth alloc] init];
    
    
    
    if (copy) {

        copy.resAuthIdentifier = self.resAuthIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
