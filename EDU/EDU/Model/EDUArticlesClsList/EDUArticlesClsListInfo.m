//
//  EDUArticlesClsListInfo.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesClsListInfo.h"


NSString *const kEDUArticlesClsListInfoId = @"id";
NSString *const kEDUArticlesClsListInfoPic = @"pic";
NSString *const kEDUArticlesClsListInfoName = @"name";
NSString *const kEDUArticlesClsListInfoSort = @"sort";


@interface EDUArticlesClsListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesClsListInfo

@synthesize infoIdentifier = _infoIdentifier;
@synthesize pic = _pic;
@synthesize name = _name;
@synthesize sort = _sort;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.infoIdentifier = [[self objectOrNilForKey:kEDUArticlesClsListInfoId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kEDUArticlesClsListInfoPic fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUArticlesClsListInfoName fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUArticlesClsListInfoSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUArticlesClsListInfoId];
    [mutableDict setValue:self.pic forKey:kEDUArticlesClsListInfoPic];
    [mutableDict setValue:self.name forKey:kEDUArticlesClsListInfoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUArticlesClsListInfoSort];

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

    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUArticlesClsListInfoId];
    self.pic = [aDecoder decodeObjectForKey:kEDUArticlesClsListInfoPic];
    self.name = [aDecoder decodeObjectForKey:kEDUArticlesClsListInfoName];
    self.sort = [aDecoder decodeDoubleForKey:kEDUArticlesClsListInfoSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_infoIdentifier forKey:kEDUArticlesClsListInfoId];
    [aCoder encodeObject:_pic forKey:kEDUArticlesClsListInfoPic];
    [aCoder encodeObject:_name forKey:kEDUArticlesClsListInfoName];
    [aCoder encodeDouble:_sort forKey:kEDUArticlesClsListInfoSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUArticlesClsListInfo *copy = [[EDUArticlesClsListInfo alloc] init];
    
    
    
    if (copy) {

        copy.infoIdentifier = self.infoIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
