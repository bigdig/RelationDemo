//
//  EDUArticlesListByClsIdShaArticlesCls.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesListByClsIdShaArticlesCls.h"


NSString *const kEDUArticlesListByClsIdShaArticlesClsId = @"id";
NSString *const kEDUArticlesListByClsIdShaArticlesClsPic = @"pic";
NSString *const kEDUArticlesListByClsIdShaArticlesClsName = @"name";
NSString *const kEDUArticlesListByClsIdShaArticlesClsSort = @"sort";


@interface EDUArticlesListByClsIdShaArticlesCls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesListByClsIdShaArticlesCls

@synthesize shaArticlesClsIdentifier = _shaArticlesClsIdentifier;
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
            self.shaArticlesClsIdentifier = [[self objectOrNilForKey:kEDUArticlesListByClsIdShaArticlesClsId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kEDUArticlesListByClsIdShaArticlesClsPic fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUArticlesListByClsIdShaArticlesClsName fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUArticlesListByClsIdShaArticlesClsSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shaArticlesClsIdentifier] forKey:kEDUArticlesListByClsIdShaArticlesClsId];
    [mutableDict setValue:self.pic forKey:kEDUArticlesListByClsIdShaArticlesClsPic];
    [mutableDict setValue:self.name forKey:kEDUArticlesListByClsIdShaArticlesClsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUArticlesListByClsIdShaArticlesClsSort];

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

    self.shaArticlesClsIdentifier = [aDecoder decodeDoubleForKey:kEDUArticlesListByClsIdShaArticlesClsId];
    self.pic = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdShaArticlesClsPic];
    self.name = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdShaArticlesClsName];
    self.sort = [aDecoder decodeDoubleForKey:kEDUArticlesListByClsIdShaArticlesClsSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_shaArticlesClsIdentifier forKey:kEDUArticlesListByClsIdShaArticlesClsId];
    [aCoder encodeObject:_pic forKey:kEDUArticlesListByClsIdShaArticlesClsPic];
    [aCoder encodeObject:_name forKey:kEDUArticlesListByClsIdShaArticlesClsName];
    [aCoder encodeDouble:_sort forKey:kEDUArticlesListByClsIdShaArticlesClsSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUArticlesListByClsIdShaArticlesCls *copy = [[EDUArticlesListByClsIdShaArticlesCls alloc] init];
    
    
    
    if (copy) {

        copy.shaArticlesClsIdentifier = self.shaArticlesClsIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
