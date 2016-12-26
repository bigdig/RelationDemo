//
//  EDUArticlesInfo.m
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesInfo.h"


NSString *const kEDUArticlesInfoId = @"id";
NSString *const kEDUArticlesInfoPic = @"pic";
NSString *const kEDUArticlesInfoName = @"name";
NSString *const kEDUArticlesInfoSort = @"sort";


@interface EDUArticlesInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesInfo

@synthesize infoIdentifier = _infoIdentifier;
@synthesize pic = _pic;
@synthesize name = _name;
@synthesize sort = _sort;


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
            self.infoIdentifier = [[self objectOrNilForKey:kEDUArticlesInfoId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kEDUArticlesInfoPic fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUArticlesInfoName fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUArticlesInfoSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUArticlesInfoId];
    [mutableDict setValue:self.pic forKey:kEDUArticlesInfoPic];
    [mutableDict setValue:self.name forKey:kEDUArticlesInfoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUArticlesInfoSort];

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

    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUArticlesInfoId];
    self.pic = [aDecoder decodeObjectForKey:kEDUArticlesInfoPic];
    self.name = [aDecoder decodeObjectForKey:kEDUArticlesInfoName];
    self.sort = [aDecoder decodeDoubleForKey:kEDUArticlesInfoSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_infoIdentifier forKey:kEDUArticlesInfoId];
    [aCoder encodeObject:_pic forKey:kEDUArticlesInfoPic];
    [aCoder encodeObject:_name forKey:kEDUArticlesInfoName];
    [aCoder encodeDouble:_sort forKey:kEDUArticlesInfoSort];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUArticlesInfo *copy = [[EDUArticlesInfo alloc] init];
    
    if (copy) {

        copy.infoIdentifier = self.infoIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
