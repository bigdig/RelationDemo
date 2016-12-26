//
//  EDUBaiduSchoolResults.m
//
//  Created by   on 2016/11/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUBaiduSchoolResults.h"
#import "EDUBaiduSchoolLocation.h"


NSString *const kEDUBaiduSchoolResultsDetail = @"detail";
NSString *const kEDUBaiduSchoolResultsStreetId = @"street_id";
NSString *const kEDUBaiduSchoolResultsUid = @"uid";
NSString *const kEDUBaiduSchoolResultsLocation = @"location";
NSString *const kEDUBaiduSchoolResultsAddress = @"address";
NSString *const kEDUBaiduSchoolResultsTelephone = @"telephone";
NSString *const kEDUBaiduSchoolResultsName = @"name";


@interface EDUBaiduSchoolResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUBaiduSchoolResults

@synthesize detail = _detail;
@synthesize streetId = _streetId;
@synthesize uid = _uid;
@synthesize location = _location;
@synthesize address = _address;
@synthesize telephone = _telephone;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.detail = [[self objectOrNilForKey:kEDUBaiduSchoolResultsDetail fromDictionary:dict] doubleValue];
            self.streetId = [self objectOrNilForKey:kEDUBaiduSchoolResultsStreetId fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kEDUBaiduSchoolResultsUid fromDictionary:dict];
            self.location = [EDUBaiduSchoolLocation modelObjectWithDictionary:[dict objectForKey:kEDUBaiduSchoolResultsLocation]];
            self.address = [self objectOrNilForKey:kEDUBaiduSchoolResultsAddress fromDictionary:dict];
            self.telephone = [self objectOrNilForKey:kEDUBaiduSchoolResultsTelephone fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUBaiduSchoolResultsName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.detail] forKey:kEDUBaiduSchoolResultsDetail];
    [mutableDict setValue:self.streetId forKey:kEDUBaiduSchoolResultsStreetId];
    [mutableDict setValue:self.uid forKey:kEDUBaiduSchoolResultsUid];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kEDUBaiduSchoolResultsLocation];
    [mutableDict setValue:self.address forKey:kEDUBaiduSchoolResultsAddress];
    [mutableDict setValue:self.telephone forKey:kEDUBaiduSchoolResultsTelephone];
    [mutableDict setValue:self.name forKey:kEDUBaiduSchoolResultsName];

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

    self.detail = [aDecoder decodeDoubleForKey:kEDUBaiduSchoolResultsDetail];
    self.streetId = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsStreetId];
    self.uid = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsUid];
    self.location = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsLocation];
    self.address = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsAddress];
    self.telephone = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsTelephone];
    self.name = [aDecoder decodeObjectForKey:kEDUBaiduSchoolResultsName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_detail forKey:kEDUBaiduSchoolResultsDetail];
    [aCoder encodeObject:_streetId forKey:kEDUBaiduSchoolResultsStreetId];
    [aCoder encodeObject:_uid forKey:kEDUBaiduSchoolResultsUid];
    [aCoder encodeObject:_location forKey:kEDUBaiduSchoolResultsLocation];
    [aCoder encodeObject:_address forKey:kEDUBaiduSchoolResultsAddress];
    [aCoder encodeObject:_telephone forKey:kEDUBaiduSchoolResultsTelephone];
    [aCoder encodeObject:_name forKey:kEDUBaiduSchoolResultsName];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUBaiduSchoolResults *copy = [[EDUBaiduSchoolResults alloc] init];
    
    
    
    if (copy) {

        copy.detail = self.detail;
        copy.streetId = [self.streetId copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
