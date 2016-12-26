//
//  EDUDramaListShaArticlesCls.m
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUDramaListShaArticlesCls.h"


NSString *const kEDUDramaListShaArticlesClsId = @"id";
NSString *const kEDUDramaListShaArticlesClsPic = @"pic";
NSString *const kEDUDramaListShaArticlesClsName = @"name";
NSString *const kEDUDramaListShaArticlesClsSort = @"sort";


@interface EDUDramaListShaArticlesCls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUDramaListShaArticlesCls

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
            self.shaArticlesClsIdentifier = [[self objectOrNilForKey:kEDUDramaListShaArticlesClsId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kEDUDramaListShaArticlesClsPic fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUDramaListShaArticlesClsName fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUDramaListShaArticlesClsSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shaArticlesClsIdentifier] forKey:kEDUDramaListShaArticlesClsId];
    [mutableDict setValue:self.pic forKey:kEDUDramaListShaArticlesClsPic];
    [mutableDict setValue:self.name forKey:kEDUDramaListShaArticlesClsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUDramaListShaArticlesClsSort];

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

    self.shaArticlesClsIdentifier = [aDecoder decodeDoubleForKey:kEDUDramaListShaArticlesClsId];
    self.pic = [aDecoder decodeObjectForKey:kEDUDramaListShaArticlesClsPic];
    self.name = [aDecoder decodeObjectForKey:kEDUDramaListShaArticlesClsName];
    self.sort = [aDecoder decodeDoubleForKey:kEDUDramaListShaArticlesClsSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_shaArticlesClsIdentifier forKey:kEDUDramaListShaArticlesClsId];
    [aCoder encodeObject:_pic forKey:kEDUDramaListShaArticlesClsPic];
    [aCoder encodeObject:_name forKey:kEDUDramaListShaArticlesClsName];
    [aCoder encodeDouble:_sort forKey:kEDUDramaListShaArticlesClsSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUDramaListShaArticlesCls *copy = [[EDUDramaListShaArticlesCls alloc] init];
    
    
    
    if (copy) {

        copy.shaArticlesClsIdentifier = self.shaArticlesClsIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
