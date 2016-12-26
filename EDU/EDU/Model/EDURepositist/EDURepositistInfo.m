//
//  EDURepositistInfo.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDURepositistInfo.h"
#import "EDURepositistList.h"


NSString *const kEDURepositistInfoList = @"list";


@interface EDURepositistInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDURepositistInfo

@synthesize list = _list;


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
    NSObject *receivedEDURepositistList = [dict objectForKey:kEDURepositistInfoList];
    NSMutableArray *parsedEDURepositistList = [NSMutableArray array];
    if ([receivedEDURepositistList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDURepositistList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDURepositistList addObject:[EDURepositistList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDURepositistList isKindOfClass:[NSDictionary class]]) {
       [parsedEDURepositistList addObject:[EDURepositistList modelObjectWithDictionary:(NSDictionary *)receivedEDURepositistList]];
    }

    self.list = [NSArray arrayWithArray:parsedEDURepositistList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kEDURepositistInfoList];

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

    self.list = [aDecoder decodeObjectForKey:kEDURepositistInfoList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kEDURepositistInfoList];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDURepositistInfo *copy = [[EDURepositistInfo alloc] init];
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
