//
//  EDUUserFavouriteInfo.m
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUUserFavouriteInfo.h"
#import "EDUUserFavouriteSacUser.h"
#import "EDUUserFavouriteResCourse.h"


NSString *const kEDUUserFavouriteInfoSacUser = @"sacUser";
NSString *const kEDUUserFavouriteInfoId = @"id";
NSString *const kEDUUserFavouriteInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUUserFavouriteInfoResCourse = @"resCourse";


@interface EDUUserFavouriteInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUUserFavouriteInfo

@synthesize sacUser = _sacUser;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize addTimeShow = _addTimeShow;
@synthesize resCourse = _resCourse;


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
            self.sacUser = [EDUUserFavouriteSacUser modelObjectWithDictionary:[dict objectForKey:kEDUUserFavouriteInfoSacUser]];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUUserFavouriteInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUUserFavouriteInfoAddTimeShow fromDictionary:dict];
            self.resCourse = [EDUUserFavouriteResCourse modelObjectWithDictionary:[dict objectForKey:kEDUUserFavouriteInfoResCourse]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.sacUser dictionaryRepresentation] forKey:kEDUUserFavouriteInfoSacUser];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUUserFavouriteInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUUserFavouriteInfoAddTimeShow];
    [mutableDict setValue:[self.resCourse dictionaryRepresentation] forKey:kEDUUserFavouriteInfoResCourse];

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

    self.sacUser = [aDecoder decodeObjectForKey:kEDUUserFavouriteInfoSacUser];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUUserFavouriteInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUUserFavouriteInfoAddTimeShow];
    self.resCourse = [aDecoder decodeObjectForKey:kEDUUserFavouriteInfoResCourse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sacUser forKey:kEDUUserFavouriteInfoSacUser];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUUserFavouriteInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUUserFavouriteInfoAddTimeShow];
    [aCoder encodeObject:_resCourse forKey:kEDUUserFavouriteInfoResCourse];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUUserFavouriteInfo *copy = [[EDUUserFavouriteInfo alloc] init];
    
    if (copy) {

        copy.sacUser = [self.sacUser copyWithZone:zone];
        copy.infoIdentifier = self.infoIdentifier;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.resCourse = [self.resCourse copyWithZone:zone];
    }
    
    return copy;
}


@end
