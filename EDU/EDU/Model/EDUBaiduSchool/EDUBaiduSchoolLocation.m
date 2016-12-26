//
//  EDUBaiduSchoolLocation.m
//
//  Created by   on 2016/11/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUBaiduSchoolLocation.h"


NSString *const kEDUBaiduSchoolLocationLat = @"lat";
NSString *const kEDUBaiduSchoolLocationLng = @"lng";


@interface EDUBaiduSchoolLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUBaiduSchoolLocation

@synthesize lat = _lat;
@synthesize lng = _lng;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lat = [[self objectOrNilForKey:kEDUBaiduSchoolLocationLat fromDictionary:dict] doubleValue];
            self.lng = [[self objectOrNilForKey:kEDUBaiduSchoolLocationLng fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kEDUBaiduSchoolLocationLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kEDUBaiduSchoolLocationLng];

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

    self.lat = [aDecoder decodeDoubleForKey:kEDUBaiduSchoolLocationLat];
    self.lng = [aDecoder decodeDoubleForKey:kEDUBaiduSchoolLocationLng];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lat forKey:kEDUBaiduSchoolLocationLat];
    [aCoder encodeDouble:_lng forKey:kEDUBaiduSchoolLocationLng];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUBaiduSchoolLocation *copy = [[EDUBaiduSchoolLocation alloc] init];
    
    
    
    if (copy) {

        copy.lat = self.lat;
        copy.lng = self.lng;
    }
    
    return copy;
}


@end
