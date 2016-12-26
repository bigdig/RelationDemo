//
//  EDUArticlesListByClsIdInfo.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesListByClsIdInfo.h"
#import "EDUArticlesListByClsIdShaArticlesCls.h"


NSString *const kEDUArticlesListByClsIdInfoSort = @"sort";
NSString *const kEDUArticlesListByClsIdInfoId = @"id";
NSString *const kEDUArticlesListByClsIdInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUArticlesListByClsIdInfoTitle = @"title";
NSString *const kEDUArticlesListByClsIdInfoDescr = @"descr";
NSString *const kEDUArticlesListByClsIdInfoThumb = @"thumb";
NSString *const kEDUArticlesListByClsIdInfoShaArticlesCls = @"shaArticlesCls";
NSString *const kEDUArticlesListByClsIdInfoMemo = @"memo";
NSString *const kEDUArticlesListByClsIdInfoUrl = @"url";


@interface EDUArticlesListByClsIdInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesListByClsIdInfo

@synthesize sort = _sort;
@synthesize infoIdentifier = _infoIdentifier;
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
            self.sort = [[self objectOrNilForKey:kEDUArticlesListByClsIdInfoSort fromDictionary:dict] doubleValue];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUArticlesListByClsIdInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoAddTimeShow fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoDescr fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoThumb fromDictionary:dict];
            self.shaArticlesCls = [EDUArticlesListByClsIdShaArticlesCls modelObjectWithDictionary:[dict objectForKey:kEDUArticlesListByClsIdInfoShaArticlesCls]];
            self.memo = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoMemo fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUArticlesListByClsIdInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUArticlesListByClsIdInfoSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUArticlesListByClsIdInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUArticlesListByClsIdInfoAddTimeShow];
    [mutableDict setValue:self.title forKey:kEDUArticlesListByClsIdInfoTitle];
    [mutableDict setValue:self.descr forKey:kEDUArticlesListByClsIdInfoDescr];
    [mutableDict setValue:self.thumb forKey:kEDUArticlesListByClsIdInfoThumb];
    [mutableDict setValue:[self.shaArticlesCls dictionaryRepresentation] forKey:kEDUArticlesListByClsIdInfoShaArticlesCls];
    [mutableDict setValue:self.memo forKey:kEDUArticlesListByClsIdInfoMemo];
    [mutableDict setValue:self.url forKey:kEDUArticlesListByClsIdInfoUrl];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDUArticlesListByClsIdInfoSort];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUArticlesListByClsIdInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoAddTimeShow];
    self.title = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoDescr];
    self.thumb = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoThumb];
    self.shaArticlesCls = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoShaArticlesCls];
    self.memo = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoMemo];
    self.url = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDUArticlesListByClsIdInfoSort];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUArticlesListByClsIdInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUArticlesListByClsIdInfoAddTimeShow];
    [aCoder encodeObject:_title forKey:kEDUArticlesListByClsIdInfoTitle];
    [aCoder encodeObject:_descr forKey:kEDUArticlesListByClsIdInfoDescr];
    [aCoder encodeObject:_thumb forKey:kEDUArticlesListByClsIdInfoThumb];
    [aCoder encodeObject:_shaArticlesCls forKey:kEDUArticlesListByClsIdInfoShaArticlesCls];
    [aCoder encodeObject:_memo forKey:kEDUArticlesListByClsIdInfoMemo];
    [aCoder encodeObject:_url forKey:kEDUArticlesListByClsIdInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUArticlesListByClsIdInfo *copy = [[EDUArticlesListByClsIdInfo alloc] init];
    
    
    
    if (copy) {

        copy.sort = self.sort;
        copy.infoIdentifier = self.infoIdentifier;
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
