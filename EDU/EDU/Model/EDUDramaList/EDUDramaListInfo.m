//
//  EDUDramaListInfo.m
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUDramaListInfo.h"
#import "EDUDramaListShaArticlesCls.h"


NSString *const kEDUDramaListInfoSort = @"sort";
NSString *const kEDUDramaListInfoId = @"id";
NSString *const kEDUDramaListInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUDramaListInfoTitle = @"title";
NSString *const kEDUDramaListInfoDescr = @"descr";
NSString *const kEDUDramaListInfoThumb = @"thumb";
NSString *const kEDUDramaListInfoShaArticlesCls = @"shaArticlesCls";
NSString *const kEDUDramaListInfoMemo = @"memo";
NSString *const kEDUDramaListInfoUrl = @"url";


@interface EDUDramaListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUDramaListInfo

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
            self.sort = [[self objectOrNilForKey:kEDUDramaListInfoSort fromDictionary:dict] doubleValue];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUDramaListInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUDramaListInfoAddTimeShow fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUDramaListInfoTitle fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDUDramaListInfoDescr fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kEDUDramaListInfoThumb fromDictionary:dict];
            self.shaArticlesCls = [EDUDramaListShaArticlesCls modelObjectWithDictionary:[dict objectForKey:kEDUDramaListInfoShaArticlesCls]];
            self.memo = [self objectOrNilForKey:kEDUDramaListInfoMemo fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUDramaListInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDUDramaListInfoSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUDramaListInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUDramaListInfoAddTimeShow];
    [mutableDict setValue:self.title forKey:kEDUDramaListInfoTitle];
    [mutableDict setValue:self.descr forKey:kEDUDramaListInfoDescr];
    [mutableDict setValue:self.thumb forKey:kEDUDramaListInfoThumb];
    [mutableDict setValue:[self.shaArticlesCls dictionaryRepresentation] forKey:kEDUDramaListInfoShaArticlesCls];
    [mutableDict setValue:self.memo forKey:kEDUDramaListInfoMemo];
    [mutableDict setValue:self.url forKey:kEDUDramaListInfoUrl];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDUDramaListInfoSort];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUDramaListInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUDramaListInfoAddTimeShow];
    self.title = [aDecoder decodeObjectForKey:kEDUDramaListInfoTitle];
    self.descr = [aDecoder decodeObjectForKey:kEDUDramaListInfoDescr];
    self.thumb = [aDecoder decodeObjectForKey:kEDUDramaListInfoThumb];
    self.shaArticlesCls = [aDecoder decodeObjectForKey:kEDUDramaListInfoShaArticlesCls];
    self.memo = [aDecoder decodeObjectForKey:kEDUDramaListInfoMemo];
    self.url = [aDecoder decodeObjectForKey:kEDUDramaListInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDUDramaListInfoSort];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUDramaListInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUDramaListInfoAddTimeShow];
    [aCoder encodeObject:_title forKey:kEDUDramaListInfoTitle];
    [aCoder encodeObject:_descr forKey:kEDUDramaListInfoDescr];
    [aCoder encodeObject:_thumb forKey:kEDUDramaListInfoThumb];
    [aCoder encodeObject:_shaArticlesCls forKey:kEDUDramaListInfoShaArticlesCls];
    [aCoder encodeObject:_memo forKey:kEDUDramaListInfoMemo];
    [aCoder encodeObject:_url forKey:kEDUDramaListInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUDramaListInfo *copy = [[EDUDramaListInfo alloc] init];
    
    
    
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
