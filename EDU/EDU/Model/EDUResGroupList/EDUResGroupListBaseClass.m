//
//  EDUResGroupListBaseClass.m
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUResGroupListBaseClass.h"
#import "EDUResGroupListInfo.h"


NSString *const kEDUResGroupListBaseClassMessage = @"message";
NSString *const kEDUResGroupListBaseClassInfo = @"info";
NSString *const kEDUResGroupListBaseClassCode = @"code";


@interface EDUResGroupListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUResGroupListBaseClass

@synthesize message = _message;
@synthesize info = _info;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kEDUResGroupListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUResGroupListInfo = [dict objectForKey:kEDUResGroupListBaseClassInfo];
    NSMutableArray *parsedEDUResGroupListInfo = [NSMutableArray array];
    
    if ([receivedEDUResGroupListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUResGroupListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUResGroupListInfo addObject:[EDUResGroupListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUResGroupListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUResGroupListInfo addObject:[EDUResGroupListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUResGroupListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUResGroupListInfo];
            self.code = [[self objectOrNilForKey:kEDUResGroupListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUResGroupListBaseClassMessage];
    NSMutableArray *tempArrayForInfo = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.info) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUResGroupListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUResGroupListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUResGroupListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUResGroupListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUResGroupListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUResGroupListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUResGroupListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUResGroupListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUResGroupListBaseClass *copy = [[EDUResGroupListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
