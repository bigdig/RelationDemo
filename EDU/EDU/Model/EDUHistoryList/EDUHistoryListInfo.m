//
//  EDUHistoryListInfo.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListInfo.h"
#import "EDUHistoryListResCourse.h"
#import "EDUHistoryListSacUser.h"


NSString *const kEDUHistoryListInfoResCourse = @"resCourse";
NSString *const kEDUHistoryListInfoId = @"id";
NSString *const kEDUHistoryListInfoSacUser = @"sacUser";
NSString *const kEDUHistoryListInfoPlayTime = @"playTime";


@interface EDUHistoryListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListInfo

@synthesize resCourse = _resCourse;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize sacUser = _sacUser;
@synthesize playTime = _playTime;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resCourse = [EDUHistoryListResCourse modelObjectWithDictionary:[dict objectForKey:kEDUHistoryListInfoResCourse]];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUHistoryListInfoId fromDictionary:dict] doubleValue];
            self.sacUser = [EDUHistoryListSacUser modelObjectWithDictionary:[dict objectForKey:kEDUHistoryListInfoSacUser]];
            self.playTime = [[self objectOrNilForKey:kEDUHistoryListInfoPlayTime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.resCourse dictionaryRepresentation] forKey:kEDUHistoryListInfoResCourse];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUHistoryListInfoId];
    [mutableDict setValue:[self.sacUser dictionaryRepresentation] forKey:kEDUHistoryListInfoSacUser];
    [mutableDict setValue:[NSNumber numberWithDouble:self.playTime] forKey:kEDUHistoryListInfoPlayTime];

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

    self.resCourse = [aDecoder decodeObjectForKey:kEDUHistoryListInfoResCourse];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUHistoryListInfoId];
    self.sacUser = [aDecoder decodeObjectForKey:kEDUHistoryListInfoSacUser];
    self.playTime = [aDecoder decodeDoubleForKey:kEDUHistoryListInfoPlayTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resCourse forKey:kEDUHistoryListInfoResCourse];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUHistoryListInfoId];
    [aCoder encodeObject:_sacUser forKey:kEDUHistoryListInfoSacUser];
    [aCoder encodeDouble:_playTime forKey:kEDUHistoryListInfoPlayTime];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListInfo *copy = [[EDUHistoryListInfo alloc] init];
    
    
    
    if (copy) {

        copy.resCourse = [self.resCourse copyWithZone:zone];
        copy.infoIdentifier = self.infoIdentifier;
        copy.sacUser = [self.sacUser copyWithZone:zone];
        copy.playTime = self.playTime;
    }
    
    return copy;
}


@end
