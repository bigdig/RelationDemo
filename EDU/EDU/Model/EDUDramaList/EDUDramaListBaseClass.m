//
//  EDUDramaListBaseClass.m
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUDramaListBaseClass.h"
#import "EDUDramaListInfo.h"


NSString *const kEDUDramaListBaseClassMessage = @"message";
NSString *const kEDUDramaListBaseClassInfo = @"info";
NSString *const kEDUDramaListBaseClassCode = @"code";


@interface EDUDramaListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUDramaListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUDramaListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUDramaListInfo = [dict objectForKey:kEDUDramaListBaseClassInfo];
    NSMutableArray *parsedEDUDramaListInfo = [NSMutableArray array];
    
    if ([receivedEDUDramaListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUDramaListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUDramaListInfo addObject:[EDUDramaListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUDramaListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUDramaListInfo addObject:[EDUDramaListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUDramaListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUDramaListInfo];
            self.code = [[self objectOrNilForKey:kEDUDramaListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUDramaListBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUDramaListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUDramaListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUDramaListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUDramaListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUDramaListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUDramaListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUDramaListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUDramaListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUDramaListBaseClass *copy = [[EDUDramaListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
