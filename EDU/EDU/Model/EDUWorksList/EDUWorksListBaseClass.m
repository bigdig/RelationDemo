//
//  EDUWorksListBaseClass.m
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUWorksListBaseClass.h"
#import "EDUWorksListInfo.h"


NSString *const kEDUWorksListBaseClassMessage = @"message";
NSString *const kEDUWorksListBaseClassInfo = @"info";
NSString *const kEDUWorksListBaseClassCode = @"code";


@interface EDUWorksListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUWorksListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUWorksListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUWorksListInfo = [dict objectForKey:kEDUWorksListBaseClassInfo];
    NSMutableArray *parsedEDUWorksListInfo = [NSMutableArray array];
    if ([receivedEDUWorksListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUWorksListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUWorksListInfo addObject:[EDUWorksListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUWorksListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUWorksListInfo addObject:[EDUWorksListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUWorksListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUWorksListInfo];
            self.code = [[self objectOrNilForKey:kEDUWorksListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUWorksListBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUWorksListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUWorksListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUWorksListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUWorksListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUWorksListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUWorksListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUWorksListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUWorksListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUWorksListBaseClass *copy = [[EDUWorksListBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
