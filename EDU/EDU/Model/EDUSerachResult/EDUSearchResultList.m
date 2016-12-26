//
//  EDUSearchResultList.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUSearchResultList.h"
#import "EDUSearchResultShaArticlesCls.h"


NSString *const kEDUSearchResultListSort = @"sort";
NSString *const kEDUSearchResultListId = @"id";
NSString *const kEDUSearchResultListAddTimeShow = @"addTimeShow";
NSString *const kEDUSearchResultListTitle = @"title";
NSString *const kEDUSearchResultListDescr = @"descr";
NSString *const kEDUSearchResultListThumb = @"thumb";
NSString *const kEDUSearchResultListShaArticlesCls = @"shaArticlesCls";
NSString *const kEDUSearchResultListMemo = @"memo";
NSString *const kEDUSearchResultListUrl = @"url";


@interface EDUSearchResultList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUSearchResultList

@synthesize sort = _sort;
@synthesize listIdentifier = _listIdentifier;
@synthesize addTimeShow = _addTimeShow;
@synthesize title = _title;
@synthesize descr = _descr;
@synthesize thumb = _thumb;
@synthesize shaArticlesCls = _shaArticlesCls;
@synthesize memo = _memo;
@synthesize url = _url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sort = [[self objectOrNilForKey:kEDUSearchResultListSort fromDictionary:dict] doubleValue];
            self.listIdentifier = [[self objectOrNilForKey:kEDUSearchResultListId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUSearchResultListAddTimeShow fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUSearchResultListTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUSearchResultListDescr fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kEDUSearchResultListThumb fromDictionary:dict];
            self.shaArticlesCls = [EDUSearchResultShaArticlesCls modelObjectWithDictionary:[dict objectForKey:kEDUSearchResultListShaArticlesCls]];
            self.memo = [self objectOrNilForKey:kEDUSearchResultListMemo fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUSearchResultListUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUSearchResultListSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kEDUSearchResultListId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUSearchResultListAddTimeShow];
    [mutableDict setValue:self.title forKey:kEDUSearchResultListTitle];
    [mutableDict setValue:self.descr forKey:kEDUSearchResultListDescr];
    [mutableDict setValue:self.thumb forKey:kEDUSearchResultListThumb];
    [mutableDict setValue:[self.shaArticlesCls dictionaryRepresentation] forKey:kEDUSearchResultListShaArticlesCls];
    [mutableDict setValue:self.memo forKey:kEDUSearchResultListMemo];
    [mutableDict setValue:self.url forKey:kEDUSearchResultListUrl];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDUSearchResultListSort];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kEDUSearchResultListId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUSearchResultListAddTimeShow];
    self.title = [aDecoder decodeObjectForKey:kEDUSearchResultListTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUSearchResultListDescr];
    self.thumb = [aDecoder decodeObjectForKey:kEDUSearchResultListThumb];
    self.shaArticlesCls = [aDecoder decodeObjectForKey:kEDUSearchResultListShaArticlesCls];
    self.memo = [aDecoder decodeObjectForKey:kEDUSearchResultListMemo];
    self.url = [aDecoder decodeObjectForKey:kEDUSearchResultListUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDUSearchResultListSort];
    [aCoder encodeDouble:_listIdentifier forKey:kEDUSearchResultListId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUSearchResultListAddTimeShow];
    [aCoder encodeObject:_title forKey:kEDUSearchResultListTitle];
    [aCoder encodeObject:_descr forKey:kEDUSearchResultListDescr];
    [aCoder encodeObject:_thumb forKey:kEDUSearchResultListThumb];
    [aCoder encodeObject:_shaArticlesCls forKey:kEDUSearchResultListShaArticlesCls];
    [aCoder encodeObject:_memo forKey:kEDUSearchResultListMemo];
    [aCoder encodeObject:_url forKey:kEDUSearchResultListUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUSearchResultList *copy = [[EDUSearchResultList alloc] init];
    
    
    
    if (copy) {

        copy.sort = self.sort;
        copy.listIdentifier = self.listIdentifier;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.shaArticlesCls = [self.shaArticlesCls copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
