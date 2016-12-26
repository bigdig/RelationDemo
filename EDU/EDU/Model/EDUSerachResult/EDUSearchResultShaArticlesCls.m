//
//  EDUSearchResultShaArticlesCls.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUSearchResultShaArticlesCls.h"


NSString *const kEDUSearchResultShaArticlesClsId = @"id";
NSString *const kEDUSearchResultShaArticlesClsPic = @"pic";
NSString *const kEDUSearchResultShaArticlesClsName = @"name";
NSString *const kEDUSearchResultShaArticlesClsSort = @"sort";


@interface EDUSearchResultShaArticlesCls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUSearchResultShaArticlesCls

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
            self.shaArticlesClsIdentifier = [[self objectOrNilForKey:kEDUSearchResultShaArticlesClsId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kEDUSearchResultShaArticlesClsPic fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDUSearchResultShaArticlesClsName fromDictionary:dict];
            self.sort = [[self objectOrNilForKey:kEDUSearchResultShaArticlesClsSort fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shaArticlesClsIdentifier] forKey:kEDUSearchResultShaArticlesClsId];
    [mutableDict setValue:self.pic forKey:kEDUSearchResultShaArticlesClsPic];
    [mutableDict setValue:self.name forKey:kEDUSearchResultShaArticlesClsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUSearchResultShaArticlesClsSort];

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

    self.shaArticlesClsIdentifier = [aDecoder decodeDoubleForKey:kEDUSearchResultShaArticlesClsId];
    self.pic = [aDecoder decodeObjectForKey:kEDUSearchResultShaArticlesClsPic];
    self.name = [aDecoder decodeObjectForKey:kEDUSearchResultShaArticlesClsName];
    self.sort = [aDecoder decodeDoubleForKey:kEDUSearchResultShaArticlesClsSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_shaArticlesClsIdentifier forKey:kEDUSearchResultShaArticlesClsId];
    [aCoder encodeObject:_pic forKey:kEDUSearchResultShaArticlesClsPic];
    [aCoder encodeObject:_name forKey:kEDUSearchResultShaArticlesClsName];
    [aCoder encodeDouble:_sort forKey:kEDUSearchResultShaArticlesClsSort];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUSearchResultShaArticlesCls *copy = [[EDUSearchResultShaArticlesCls alloc] init];
    
    
    
    if (copy) {

        copy.shaArticlesClsIdentifier = self.shaArticlesClsIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.sort = self.sort;
    }
    
    return copy;
}


@end
