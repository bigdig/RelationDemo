//
//  EDUUserFavouriteBaseClass.m
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUUserFavouriteBaseClass.h"
#import "EDUUserFavouriteInfo.h"


NSString *const kEDUUserFavouriteBaseClassMessage = @"message";
NSString *const kEDUUserFavouriteBaseClassInfo = @"info";
NSString *const kEDUUserFavouriteBaseClassCode = @"code";


@interface EDUUserFavouriteBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUUserFavouriteBaseClass

@synthesize message = _message;
@synthesize info = _info;
@synthesize code = _code;


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
            self.message = [self objectOrNilForKey:kEDUUserFavouriteBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUUserFavouriteInfo = [dict objectForKey:kEDUUserFavouriteBaseClassInfo];
    NSMutableArray *parsedEDUUserFavouriteInfo = [NSMutableArray array];
    if ([receivedEDUUserFavouriteInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUUserFavouriteInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUUserFavouriteInfo addObject:[EDUUserFavouriteInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUUserFavouriteInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUUserFavouriteInfo addObject:[EDUUserFavouriteInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUUserFavouriteInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUUserFavouriteInfo];
            self.code = [[self objectOrNilForKey:kEDUUserFavouriteBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUUserFavouriteBaseClassMessage];
    NSMutableArray *tempArrayForInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.info) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUUserFavouriteBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUUserFavouriteBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUUserFavouriteBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUUserFavouriteBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUUserFavouriteBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUUserFavouriteBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUUserFavouriteBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUUserFavouriteBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUUserFavouriteBaseClass *copy = [[EDUUserFavouriteBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
