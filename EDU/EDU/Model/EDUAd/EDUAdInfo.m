//
//  EDUAdInfo.m
//
//  Created by   on 2016/12/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUAdInfo.h"


NSString *const kEDUAdInfoPic = @"pic";
NSString *const kEDUAdInfoTitle = @"title";
NSString *const kEDUAdInfoUrl = @"url";


@interface EDUAdInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUAdInfo

@synthesize pic = _pic;
@synthesize title = _title;
@synthesize url = _url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.pic = [self objectOrNilForKey:kEDUAdInfoPic fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUAdInfoTitle fromDictionary:dict];
            self.url = [self objectOrNilForKey:kEDUAdInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pic forKey:kEDUAdInfoPic];
    [mutableDict setValue:self.title forKey:kEDUAdInfoTitle];
    [mutableDict setValue:self.url forKey:kEDUAdInfoUrl];

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

    self.pic = [aDecoder decodeObjectForKey:kEDUAdInfoPic];
    self.title = [aDecoder decodeObjectForKey:kEDUAdInfoTitle];
    self.url = [aDecoder decodeObjectForKey:kEDUAdInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pic forKey:kEDUAdInfoPic];
    [aCoder encodeObject:_title forKey:kEDUAdInfoTitle];
    [aCoder encodeObject:_url forKey:kEDUAdInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUAdInfo *copy = [[EDUAdInfo alloc] init];
    
    
    
    if (copy) {

        copy.pic = [self.pic copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
