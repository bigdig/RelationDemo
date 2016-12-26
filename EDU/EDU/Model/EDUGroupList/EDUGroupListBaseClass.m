//
//  EDUGroupListBaseClass.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupListBaseClass.h"
#import "EDUGroupListInfo.h"


NSString *const kEDUGroupListBaseClassMessage = @"message";
NSString *const kEDUGroupListBaseClassInfo = @"info";
NSString *const kEDUGroupListBaseClassCode = @"code";


@interface EDUGroupListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUGroupListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUGroupListInfo = [dict objectForKey:kEDUGroupListBaseClassInfo];
    NSMutableArray *parsedEDUGroupListInfo = [NSMutableArray array];
    if ([receivedEDUGroupListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUGroupListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUGroupListInfo addObject:[EDUGroupListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUGroupListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUGroupListInfo addObject:[EDUGroupListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUGroupListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUGroupListInfo];
            self.code = [[self objectOrNilForKey:kEDUGroupListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUGroupListBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUGroupListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUGroupListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUGroupListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUGroupListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUGroupListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUGroupListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUGroupListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUGroupListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupListBaseClass *copy = [[EDUGroupListBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
